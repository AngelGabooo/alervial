import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../../../core/widgets/gradient_background.dart';
import '../widgets/loading_message.dart';

class LoadingScreenPage extends StatefulWidget {
  final String? initialMessage;
  final VoidCallback? onLoadingComplete;
  final String? nextRoute;

  const LoadingScreenPage({
    super.key,
    this.initialMessage,
    this.onLoadingComplete,
    this.nextRoute,
  });

  @override
  State<LoadingScreenPage> createState() => _LoadingScreenPageState();
}

class _LoadingScreenPageState extends State<LoadingScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  String _currentMessage = 'Cargando...';
  int _messageIndex = 0;

  final List<String> _messages = [
    'Cargando mapa...',
    'Verificando ubicación...',
    'Sincronizando reportes...',
    'Conectando con servidores...',
    'Casi listo...',
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startMessageRotation();
    _handleNavigation();
  }

  void _initAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startMessageRotation() {
    if (widget.initialMessage != null) {
      _currentMessage = widget.initialMessage!;
      return;
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _messageIndex < _messages.length - 1) {
        setState(() {
          _messageIndex++;
          _currentMessage = _messages[_messageIndex];
        });
        _startMessageRotation();
      }
    });
  }

  Future<void> _handleNavigation() async {
    // Esperar tiempo mínimo de carga
    await Future.delayed(const Duration(seconds: 2));

    if (widget.onLoadingComplete != null) {
      widget.onLoadingComplete!();
    }

    if (widget.nextRoute != null && mounted) {
      Navigator.pushReplacementNamed(context, widget.nextRoute!);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return GradientBackground(
      hasPattern: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo animado
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              size: resp.iconSize(100),
                              color: Colors.white,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'ALERTAVIAL\nCHIAPAS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: resp.sp(28),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                                shadows: [
                                  Shadow(
                                    blurRadius: 20,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 60),
                // Indicador de progreso
                SizedBox(
                  width: resp.wp(10),
                  height: resp.wp(10),
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.softGreen),
                  ),
                ),
                const SizedBox(height: 24),
                // Mensaje variable
                LoadingMessage(message: _currentMessage),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}