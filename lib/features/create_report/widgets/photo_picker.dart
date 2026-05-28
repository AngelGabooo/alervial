import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class PhotoPicker extends StatelessWidget {
  final Function(String) onPhotoSelected;

  const PhotoPicker({super.key, required this.onPhotoSelected});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Evidencia',
          style: TextStyle(
            fontSize: resp.sp(16),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        Container(
          height: resp.hp(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo_rounded,
                size: resp.iconSize(40),
                color: isDark ? Colors.grey[500] : Colors.grey[400],
              ),
              SizedBox(height: resp.hp(1)),
              Text(
                'Toma una fotografía',
                style: TextStyle(
                  fontSize: resp.sp(14),
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                ),
              ),
              Text(
                'o elige desde galería',
                style: TextStyle(
                  fontSize: resp.sp(12),
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                ),
              ),
              SizedBox(height: resp.hp(1.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(
                    context,
                    Icons.camera_alt_rounded,
                    'Cámara',
                        () {
                      // Simular selección de foto
                      onPhotoSelected('photo_path_${DateTime.now().millisecondsSinceEpoch}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cámara - Próximamente')),
                      );
                    },
                  ),
                  SizedBox(width: resp.wp(4)),
                  _buildButton(
                    context,
                    Icons.photo_library_rounded,
                    'Galería',
                        () {
                      // Simular selección de foto
                      onPhotoSelected('photo_path_${DateTime.now().millisecondsSinceEpoch}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Galería - Próximamente')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String label, VoidCallback onPressed) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: resp.iconSize(18)),
      label: Text(label, style: TextStyle(fontSize: resp.sp(13))),
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? Colors.white : Colors.black87,
        side: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey[300]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}