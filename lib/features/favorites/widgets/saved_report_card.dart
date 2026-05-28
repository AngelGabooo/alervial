import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class SavedReportCard extends StatelessWidget {
  final String imageUrl;
  final String status;
  final String risk;
  final String title;
  final String time;
  final String location;
  final bool isPending;

  const SavedReportCard({
    super.key,
    required this.imageUrl,
    required this.status,
    required this.risk,
    required this.title,
    required this.time,
    required this.location,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: resp.radius(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(resp.radius(16).topLeft.x),
                    topRight: Radius.circular(resp.radius(16).topRight.x),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported_rounded),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: resp.radius(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBadge(status, isPending ? Colors.red : Colors.orange),
                      const SizedBox(height: 4),
                      _buildBadge(risk, isPending ? Colors.red[900]! : Colors.orange[800]!),
                    ],
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: resp.padding(all: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: resp.sp(13)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(time, style: TextStyle(color: Colors.grey, fontSize: resp.sp(10))),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, size: 12, color: Colors.grey),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(fontSize: resp.sp(10), color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueBright,
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, resp.hp(3.5)),
                          shape: RoundedRectangleBorder(borderRadius: resp.radius(8)),
                        ),
                        onPressed: () {},
                        child: Text('Ver detalle', style: TextStyle(color: Colors.white, fontSize: resp.sp(11))),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined, size: 18, color: Colors.grey),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }
}