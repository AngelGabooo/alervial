import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart' show AppColors;
import '../../../core/widgets/page_indicator.dart';

class NavigationButtons extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;
  final VoidCallback onComplete;

  const NavigationButtons({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.totalPages,
    required this.onSkip,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLastPage = currentPage == totalPages - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onSkip,
            child: Text(
              'Omitir',
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ),
          PageIndicator(currentPage: currentPage, totalPages: totalPages),
          ElevatedButton(
            onPressed: () {
              if (isLastPage) {
                onComplete();
              } else {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueBright,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Text(
              isLastPage ? 'Comenzar' : 'Siguiente',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}