import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class LiveMapCard extends StatelessWidget {
  const LiveMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: resp.hp(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.grey[300],
        borderRadius: resp.radius(16),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1524661135-423995f22d0b'),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.9), borderRadius: BorderRadius.circular(6)),
              child: const Text('● En vivo: 12 cerca', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold), maxLines: 1),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
              child: const Text('8 reportando', style: TextStyle(color: Colors.white, fontSize: 9)),
            ),
          ),
          const Center(child: Icon(Icons.my_location_rounded, color: Colors.blue, size: 28)),
        ],
      ),
    );
  }
}