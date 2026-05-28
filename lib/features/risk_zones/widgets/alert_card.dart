import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(resp.wp(3)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.red.shade800],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.red.withOpacity(0.4), blurRadius: 15),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(resp.wp(2)),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.warning_rounded, color: Colors.red, size: resp.iconSize(20)),
          ),
          SizedBox(width: resp.wp(3)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Alerta! Derrumbe detectado',
                  style: TextStyle(
                    fontSize: resp.sp(14),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Carretera Tuxtla - San Cristóbal',
                  style: TextStyle(fontSize: resp.sp(12), color: Colors.white70),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Ver', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}