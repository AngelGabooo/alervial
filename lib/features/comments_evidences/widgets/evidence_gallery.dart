import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class EvidenceGallery extends StatelessWidget {
  const EvidenceGallery({super.key});

  final List<String> _evidences = const [
    'Evidencia 1',
    'Evidencia 2',
    'Evidencia 3',
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Evidencia visual',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        SizedBox(
          height: resp.hp(18),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _evidences.length,
            itemBuilder: (context, index) {
              return Container(
                width: resp.wp(35),
                margin: EdgeInsets.only(right: resp.wp(3)),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: NetworkImage('https://picsum.photos/200/150'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: resp.hp(1),
                      right: resp.wp(2),
                      child: Container(
                        padding: EdgeInsets.all(resp.wp(1.5)),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.zoom_out_map_rounded,
                            size: resp.iconSize(16), color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}