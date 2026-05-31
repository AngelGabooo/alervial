import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/services/connectivity_service.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/connection_error_illustration.dart';

class NoConnectionPage extends StatefulWidget {
  final bool showPublicMapOption;

  const NoConnectionPage({
    super.key,
    this.showPublicMapOption = true,
  });

  @override
  State<NoConnectionPage> createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  bool _isRetrying = false;

  @override
  void initState() {
    super.initState();
    // Verificar periódicamente la conexión
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startPeriodicCheck();
    });
  }

  void _startPeriodicCheck() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _checkConnectionAutomatically();
        _startPeriodicCheck();
      }
    });
  }

  Future<void> _checkConnectionAutomatically() async {
    final hasConnection = await ConnectivityService.hasConnection();
    if (hasConnection && mounted) {
      _navigateToNextScreen();
    }
  }

  Future<void> _retryConnection() async {
    setState(() => _isRetrying = true);

    final hasConnection = await ConnectivityService.hasConnection();

    setState(() => _isRetrying = false);

    if (hasConnection && mounted) {
      _navigateToNextScreen();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aún sin conexión. Revisa tu internet.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
  }

  void _goToPublicMap(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.interactiveMap);
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(resp.wp(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              const ConnectionErrorIllustration(),
              const SizedBox(height: 32),
              Text(
                'Sin conexión a internet',
                style: TextStyle(
                  fontSize: resp.sp(24),
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.blueDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Revisa tu conexión y vuelve a intentarlo.\nLos reportes se guardarán para enviarlos cuando vuelvas a estar en línea.',
                style: TextStyle(
                  fontSize: resp.sp(14),
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: resp.buttonHeight(52),
                child: ElevatedButton(
                  onPressed: _isRetrying ? null : _retryConnection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueBright,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: _isRetrying
                      ? SizedBox(
                    width: resp.wp(6),
                    height: resp.wp(6),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : Text(
                    'Reintentar',
                    style: TextStyle(fontSize: resp.sp(16), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (widget.showPublicMapOption)
                SizedBox(
                  width: double.infinity,
                  height: resp.buttonHeight(48),
                  child: OutlinedButton(
                    onPressed: () => _goToPublicMap(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.blueBright,
                      side: BorderSide(color: AppColors.blueBright),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Ir al mapa público',
                      style: TextStyle(fontSize: resp.sp(14), fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              const Spacer(flex: 1),
              Text(
                'Tus datos están seguros',
                style: TextStyle(
                  fontSize: resp.sp(11),
                  color: isDark ? Colors.grey[500] : Colors.grey[500],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}