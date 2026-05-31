import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class ConnectionErrorIllustration extends StatelessWidget {
  const ConnectionErrorIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: resp.wp(50),
      height: resp.wp(50),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.wifi_rounded,
            size: resp.iconSize(60),
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
          Positioned(
            top: resp.hp(5),
            right: resp.wp(10),
            child: Container(
              padding: EdgeInsets.all(resp.wp(2)),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                Icons.close_rounded,
                size: resp.iconSize(20),
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: resp.hp(5),
            left: resp.wp(12),
            child: Container(
              padding: EdgeInsets.all(resp.wp(2)),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.signal_wifi_off_rounded,
                size: resp.iconSize(16),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}