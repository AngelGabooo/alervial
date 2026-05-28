import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/core/constants/colors.dart';

class ForgotPasswordIllustration extends StatelessWidget {
  const ForgotPasswordIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Center(
      child: Container(
        height: resp.hp(20),
        width: resp.hp(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.email_outlined,
              size: resp.iconSize(50),
              color: Colors.white.withOpacity(0.8),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: resp.padding(all: 8),
                decoration: BoxDecoration(
                  color: AppColors.softGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.softGreen.withOpacity(0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: resp.iconSize(20),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Import necesario
