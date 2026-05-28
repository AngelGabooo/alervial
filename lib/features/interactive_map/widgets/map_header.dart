import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';

class MapHeader extends StatelessWidget {
  const MapHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(resp.wp(4)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: resp.wp(4), vertical: resp.hp(1)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded, size: resp.iconSize(20), color: Colors.grey[600]),
                      SizedBox(width: resp.wp(2)),
                      Expanded(
                        child: Text(
                          'Buscar lugar o incidencia...',
                          style: TextStyle(fontSize: resp.sp(14), color: Colors.grey[500]),
                        ),
                      ),
                      Icon(Icons.filter_list_rounded, size: resp.iconSize(20), color: Colors.grey[600]),
                    ],
                  ),
                ),
              ),
              SizedBox(width: resp.wp(3)),
              Container(
                padding: EdgeInsets.all(resp.wp(2.5)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(Icons.my_location_rounded, size: resp.iconSize(22), color: AppColors.blueBright),
              ),
            ],
          ),
        ),
      ),
    );
  }
}