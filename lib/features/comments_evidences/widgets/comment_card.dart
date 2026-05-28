import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class CommentCard extends StatelessWidget {
  final Map<String, dynamic> comment;
  final VoidCallback onLike;

  const CommentCard({
    super.key,
    required this.comment,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: resp.wp(5), vertical: resp.hp(0.5)),
      child: Card(
        elevation: 0,
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(resp.wp(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: comment['isOfficial']
                        ? AppColors.blueBright
                        : (isDark ? Colors.grey[600] : Colors.grey[300]),
                    radius: resp.wp(5),
                    child: Text(
                      comment['userAvatar'],
                      style: TextStyle(
                        color: comment['isOfficial'] ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.bold,
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
                              comment['userName'],
                              style: TextStyle(
                                fontSize: resp.sp(14),
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            SizedBox(width: resp.wp(2)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: resp.wp(2),
                                vertical: resp.hp(0.3),
                              ),
                              decoration: BoxDecoration(
                                color: comment['isOfficial']
                                    ? AppColors.blueBright.withOpacity(0.2)
                                    : Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                comment['userRole'],
                                style: TextStyle(
                                  fontSize: resp.sp(10),
                                  color: comment['isOfficial'] ? AppColors.blueBright : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          comment['time'],
                          style: TextStyle(
                            fontSize: resp.sp(11),
                            color: isDark ? Colors.grey[500] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert_rounded,
                        size: resp.iconSize(18), color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: resp.hp(1.5)),
              Text(
                comment['comment'],
                style: TextStyle(
                  fontSize: resp.sp(14),
                  color: isDark ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              if (comment['imageUrl'] != null) ...[
                SizedBox(height: resp.hp(1.5)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: comment['imageUrl']?.startsWith('http') == true
                      ? Image.network(
                    comment['imageUrl'],
                    height: resp.hp(20),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: resp.hp(20),
                        width: double.infinity,
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        child: const Icon(Icons.broken_image, size: 40),
                      );
                    },
                  )
                      : Container(
                    height: resp.hp(20),
                    width: double.infinity,
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    child: const Icon(Icons.image_outlined, size: 40),
                  ),
                ),
              ],
              if (comment['location'] != null) ...[
                SizedBox(height: resp.hp(1)),
                Container(
                  padding: EdgeInsets.all(resp.wp(2)),
                  decoration: BoxDecoration(
                    color: AppColors.blueBright.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_rounded, size: resp.iconSize(14), color: AppColors.blueBright),
                      SizedBox(width: resp.wp(2)),
                      Expanded(
                        child: Text(
                          comment['location'],
                          style: TextStyle(fontSize: resp.sp(12), color: AppColors.blueBright),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: resp.hp(1)),
              Row(
                children: [
                  GestureDetector(
                    onTap: onLike,
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          size: resp.iconSize(18),
                          color: Colors.grey,
                        ),
                        SizedBox(width: resp.wp(1)),
                        Text(
                          '${comment['likes']}',
                          style: TextStyle(color: Colors.grey, fontSize: resp.sp(12)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: resp.wp(4)),
                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: resp.iconSize(18),
                        color: Colors.grey,
                      ),
                      SizedBox(width: resp.wp(1)),
                      Text(
                        '${comment['comments']}',
                        style: TextStyle(color: Colors.grey, fontSize: resp.sp(12)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Responder',
                      style: TextStyle(
                        fontSize: resp.sp(12),
                        color: AppColors.blueBright,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}