import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: resp.hp(22),
      width: double.infinity,
      padding: EdgeInsets.all(resp.wp(4)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade700, Colors.red.shade900],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
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
                  'CRÍTICO',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const Spacer(),
              Text(
                'Hace 5 min',
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'Derrumbe en carretera',
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
                  'En proceso',
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