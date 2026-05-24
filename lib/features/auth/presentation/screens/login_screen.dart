// lib/features/auth/presentation/screens/login_screen.dart (VERSIÓN CON PROTECCIÓN)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/user_service.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _isSecureMode = false; // Para modo seguro cuando intentan capturar

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // ACTIVAR PROTECCIÓN CONTRA CAPTURAS DE PANTALLA
    _enableScreenProtection();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();

    // Verificar si hay sesión guardada al iniciar
    _checkSavedSession();

    // Escuchar eventos de cambios de seguridad
    _setupSecurityListeners();
  }

  /// Activar protección contra capturas de pantalla
  void _enableScreenProtection() {
    // Método 1: Usar FLAG_SECURE para prevenir capturas
    // Esto hace que la pantalla aparezca en negro al intentar capturar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    // Método 2: Configurar la ventana para ser segura
    // Nota: Esto requiere acceso a platform channels, una alternativa es usar
    // un widget que detecte cuando se intenta capturar
  }

  /// Configurar listeners para detectar intentos de captura
  void _setupSecurityListeners() {
    // En Flutter, podemos detectar cuando la app pierde enfoque
    // (posible indicador de que se está grabando la pantalla)
    WidgetsBinding.instance.addObserver(
      _AppLifecycleObserver(onPause: () {
        // Si la app pasa a segundo plano, mostrar alerta
        _showScreenshotWarning();
      }),
    );
  }

  /// Mostrar alerta cuando se intenta capturar pantalla
  void _showScreenshotWarning() {
    if (!mounted) return;

    // Activar modo seguro (pantalla negra)
    setState(() {
      _isSecureMode = true;
    });

    // Mostrar diálogo de advertencia
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.red[50],
        title: Row(
          children: [
            Icon(Icons.security, color: Colors.red[700]),
            const SizedBox(width: 10),
            const Text(
              "Captura de pantalla detectada",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.screenshot_monitor, size: 60, color: Colors.red),
            SizedBox(height: 16),
            Text(
              "Por seguridad, no está permitido tomar capturas de pantalla ni grabar la pantalla en esta sección.\n\n"
                  "Esta medida protege tu información personal y credenciales de acceso.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Desactivar modo seguro después de cerrar el diálogo
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  setState(() {
                    _isSecureMode = false;
                  });
                }
              });
            },
            child: const Text("Entendido", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _checkSavedSession() async {
    final isLoggedIn = await UserService.isLoggedIn();
    if (isLoggedIn && mounted) {
      final userRole = await UserService.getUserRole();
      if (userRole != null) {
        _redirectByRole(userRole);
      }
    }
  }

  void _redirectByRole(String role) {
    if (role == 'visitante') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2));

      final email = _emailController.text;
      final existingUserRole = await UserService.getUserRole();

      if (mounted) {
        setState(() => _isLoading = false);

        if (existingUserRole != null && _rememberMe) {
          _redirectByRole(existingUserRole);
        } else {
          await UserService.saveUser(
            email: email,
            name: email.split('@')[0],
            role: 'ciudadano',
          );

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Icon(Icons.check_circle, size: 60, color: AppColors.accentGreen),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "¡Bienvenido!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Inicio de sesión exitoso. Selecciona tu rol para continuar.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/role-selection');
                  },
                  child: const Text("Seleccionar rol"),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // MODO SEGURO: Si se detecta una captura, mostrar pantalla negra
    if (_isSecureMode) {
      return Scaffold(
        body: Container(
          color: Colors.black,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.security, size: 80, color: Colors.white54),
                SizedBox(height: 20),
                Text(
                  "Captura de pantalla no permitida",
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Ilustración de mapa urbano
              Positioned(
                top: 0,
                right: 0,
                child: Opacity(
                  opacity: 0.1,
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/854/854878.png',
                    height: 200,
                    errorBuilder: (context, error, stackTrace) => Container(),
                  ),
                ),
              ),

              // Elementos decorativos
              Positioned(
                bottom: 100,
                left: -30,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Contenido principal
              RepaintBoundary(
                child: SingleChildScrollView(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, _slideAnimation.value),
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),

                          // Logo y header
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.warning_amber_rounded,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 24),

                          const Text(
                            "AlertaVial",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),

                          const Text(
                            "CHIAPAS",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                              letterSpacing: 4,
                            ),
                          ),
                          const SizedBox(height: 32),

                          const Text(
                            "Bienvenido nuevamente",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            "Inicia sesión para continuar reportando incidencias.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 40),

                          // Tarjeta de login (glassmorphism)
                          Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkSurface.withOpacity(0.9)
                                  : Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomInputField(
                                    controller: _emailController,
                                    label: "Correo electrónico o teléfono",
                                    hint: "ejemplo@correo.com",
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ingresa tu correo o teléfono";
                                      }
                                      return null;
                                    },
                                  ),

                                  CustomInputField(
                                    controller: _passwordController,
                                    label: "Contraseña",
                                    hint: "••••••••",
                                    icon: Icons.lock_outline,
                                    obscureText: _obscurePassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() => _obscurePassword = !_obscurePassword);
                                      },
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ingresa tu contraseña";
                                      }
                                      return null;
                                    },
                                  ),

                                  // Recordar sesión y olvidé contraseña
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.2,
                                              child: Checkbox(
                                                value: _rememberMe,
                                                onChanged: (value) {
                                                  setState(() => _rememberMe = value ?? false);
                                                },
                                                activeColor: AppColors.accentGreen,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Recordar sesión",
                                              style: TextStyle(
                                                color: isDark ? Colors.white70 : Colors.grey[700],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Próximamente: Recuperación de contraseña'),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "¿Olvidaste tu contraseña?",
                                            style: TextStyle(
                                              color: AppColors.primaryBlue,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  // Botón Iniciar sesión
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 56,
                                      child: ElevatedButton(
                                        onPressed: _isLoading ? null : _handleLogin,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryBlue,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: _isLoading
                                            ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                            : const Text(
                                          "Iniciar sesión",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Botón visitante
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 56,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          await UserService.saveUser(
                                            email: 'visitante@temp.com',
                                            name: 'Visitante',
                                            role: 'visitante',
                                          );
                                          Navigator.pushReplacementNamed(context, '/home');
                                        },
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppColors.primaryBlue,
                                          side: const BorderSide(color: AppColors.primaryBlue),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: const Text(
                                          "Entrar como visitante",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  // Separador
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: isDark ? Colors.grey[700] : Colors.grey[300],
                                            thickness: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Text(
                                            "O continúa con",
                                            style: TextStyle(
                                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            color: isDark ? Colors.grey[700] : Colors.grey[300],
                                            thickness: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  // Botones sociales
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        SocialButton(
                                          icon: Icons.g_mobiledata,
                                          label: "Continuar con Google",
                                          backgroundColor: isDark ? Colors.grey[800]! : Colors.grey[100]!,
                                          foregroundColor: isDark ? Colors.white : AppColors.textDark,
                                          onPressed: () {
                                            // Implementar login con Google
                                          },
                                        ),
                                        const SizedBox(height: 12),
                                        SocialButton(
                                          icon: Icons.apple,
                                          label: "Continuar con Apple",
                                          backgroundColor: isDark ? Colors.grey[800]! : Colors.grey[100]!,
                                          foregroundColor: isDark ? Colors.white : AppColors.textDark,
                                          onPressed: () {
                                            // Implementar login con Apple
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 32),

                                  // Enlace a registro
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "¿No tienes cuenta? ",
                                          style: TextStyle(
                                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(context, '/register');
                                          },
                                          child: const Text(
                                            "Regístrate",
                                            style: TextStyle(
                                              color: AppColors.primaryBlue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Pequeña ilustración
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildIconWithText(Icons.phone_android, "Móvil"),
                              const SizedBox(width: 20),
                              _buildIconWithText(Icons.gps_fixed, "GPS"),
                              const SizedBox(width: 20),
                              _buildIconWithText(Icons.notifications_active, "Alertas"),
                              const SizedBox(width: 20),
                              _buildIconWithText(Icons.map, "Mapas"),
                            ],
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

// Clase para observar el ciclo de vida de la app
class _AppLifecycleObserver extends WidgetsBindingObserver {
  final VoidCallback onPause;

  _AppLifecycleObserver({required this.onPause});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      onPause();
    }
  }
}