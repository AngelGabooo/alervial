import 'package:flutter/material.dart';
import 'package:viatux/core/utils/responsive.dart';

class TrendingSearches extends StatelessWidget {
  const TrendingSearches({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🕐 Recientes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: resp.sp(13))),
        Wrap(
          spacing: 4,
          children: ['Libramiento N.', 'San Cristóbal'].map((tag) => Chip(
            label: Text(tag, style: TextStyle(fontSize: resp.sp(10))),
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )).toList(),
        ),
        const SizedBox(height: 8),
        Text('📈 Tendencias', style: TextStyle(fontWeight: FontWeight.bold, fontSize: resp.sp(13))),
        _trendItem('Baches en Tuxtla', '84 hoy', resp),
        _trendItem('Derrumbes rec.', 'Carretera', resp),
      ],
    );
  }

  Widget _trendItem(String title, String sub, Responsive resp) {
    return Row(
      children: [
        const Icon(Icons.search_rounded, size: 12, color: Colors.blue),
        const SizedBox(width: 4),
        Expanded(child: Text(title, style: TextStyle(fontSize: resp.sp(11), fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}