import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class BottomSheetDetail extends StatelessWidget {
  final VoidCallback onClose;

  const BottomSheetDetail({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: resp.hp(1)),
                width: resp.wp(12),
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(resp.wp(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(resp.wp(3)),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.warning_rounded, color: Colors.orange, size: resp.iconSize(28)),
                          ),
                          SizedBox(width: resp.wp(4)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bache profundo',
                                  style: TextStyle(
                                    fontSize: resp.sp(18),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Av. Central #123', style: TextStyle(fontSize: resp.sp(13), color: Colors.grey)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close_rounded, size: resp.iconSize(20)),
                            onPressed: onClose,
                          ),
                        ],
                      ),
                      SizedBox(height: resp.hp(2)),
                      Row(
                        children: [
                          _buildInfoChip(context, 'Crítico', Colors.red),
                          SizedBox(width: resp.wp(3)),
                          _buildInfoChip(context, 'Pendiente', Colors.orange),
                          SizedBox(width: resp.wp(3)),
                          _buildInfoChip(context, 'A 250m', Colors.grey),
                        ],
                      ),
                      SizedBox(height: resp.hp(2)),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: resp.iconSize(16), color: Colors.grey),
                          SizedBox(width: resp.wp(2)),
                          Text('Reportado hace 2 horas', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: resp.hp(2)),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blueBright,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: resp.hp(1.5)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('Ver detalle', style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(BuildContext context, String text, Color color) {
    final resp = context.resp;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(3), vertical: resp.hp(0.5)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text, style: TextStyle(fontSize: resp.sp(12), color: color, fontWeight: FontWeight.w500)),
    );
  }
}