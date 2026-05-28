import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class CriticalAlertCard extends StatelessWidget {
  const CriticalAlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Container(
      height: resp.hp(22),
      width: double.infinity,
      padding: EdgeInsets.all(resp.wp(4)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade700, Colors.red.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resp.wp(2),
                  vertical: resp.hp(0.3),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ALERTA CRÍTICA',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const Spacer(),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(resp.wp(1.5)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.warning_rounded,
                      size: resp.iconSize(16), color: Colors.white),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'Derrumbe detectado',
            style: TextStyle(
              fontSize: resp.sp(20),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: resp.hp(0.5)),
          Row(
            children: [
              Icon(Icons.location_on_rounded, size: resp.iconSize(14), color: Colors.white70),
              SizedBox(width: resp.wp(1)),
              Text(
                'Carretera Tuxtla - San Cristóbal',
                style: TextStyle(color: Colors.white70, fontSize: resp.sp(12)),
              ),
            ],
          ),
          SizedBox(height: resp.hp(1.5)),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resp.wp(2),
                  vertical: resp.hp(0.3),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'A 2.5 km',
                  style: TextStyle(color: Colors.white, fontSize: resp.sp(11)),
                ),
              ),
              SizedBox(width: resp.wp(2)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resp.wp(2),
                  vertical: resp.hp(0.3),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Riesgo extremo',
                  style: TextStyle(color: Colors.white, fontSize: resp.sp(11)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}