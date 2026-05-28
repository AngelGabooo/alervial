import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  final List<Map<String, dynamic>> _comments = const [
    {
      'user': 'Autoridad Municipal',
      'avatar': 'A',
      'time': 'Hace 2 horas',
      'comment': 'Hemos recibido su reporte y será atendido en las próximas 24 horas.',
      'isOfficial': true,
      'icon': Icons.verified_rounded,
    },
    {
      'user': 'Carlos M.',
      'avatar': 'C',
      'time': 'Hace 1 hora',
      'comment': 'También vi ese bache, es muy peligroso. Espero lo arreglen pronto.',
      'isOfficial': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comentarios',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: resp.hp(1.5)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _comments.length,
          itemBuilder: (context, index) {
            final comment = _comments[index];
            return Container(
              margin: EdgeInsets.only(bottom: resp.hp(1.5)),
              padding: EdgeInsets.all(resp.wp(3)),
              decoration: BoxDecoration(
                color: comment['isOfficial']
                    ? AppColors.blueBright.withOpacity(0.1)
                    : (isDark ? Colors.grey[800] : Colors.grey[100]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: comment['isOfficial']
                        ? AppColors.blueBright
                        : (isDark ? Colors.grey[600] : Colors.grey[300]),
                    child: Text(
                      comment['avatar'],
                      style: TextStyle(
                        color: comment['isOfficial'] ? Colors.white : Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(width: resp.wp(3)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              comment['user'],
                              style: TextStyle(
                                fontSize: resp.sp(14),
                                fontWeight: FontWeight.w600,
                                color: comment['isOfficial']
                                    ? AppColors.blueBright
                                    : (isDark ? Colors.white : Colors.black87),
                              ),
                            ),
                            if (comment['isOfficial']) ...[
                              SizedBox(width: resp.wp(1)),
                              Icon(Icons.verified_rounded,
                                  size: resp.iconSize(14), color: AppColors.blueBright),
                            ],
                            const Spacer(),
                            Text(
                              comment['time'],
                              style: TextStyle(
                                fontSize: resp.sp(11),
                                color: isDark ? Colors.grey[500] : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: resp.hp(0.5)),
                        Text(
                          comment['comment'],
                          style: TextStyle(
                            fontSize: resp.sp(13),
                            color: isDark ? Colors.grey[300] : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}