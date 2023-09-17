import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';
import '../../theme/theme_styles.dart';

class ResponseFeedback extends StatelessWidget {
  /// type of feedback
  final bool isSuccess;

  /// title of the feedback
  final String title;

  /// message of the feedback
  final String message;

  const ResponseFeedback(
      {super.key,
      this.isSuccess = true,
      required this.title,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSuccess ? ThemeColors.success : ThemeColors.error1,
        borderRadius: BorderRadius.circular(Corners.s5),
      ),
      child: Column(
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isSuccess ? ThemeColors.white : ThemeColors.error,
              ),
            ),
          if (title.isNotEmpty && message.isNotEmpty)
            const SizedBox(height: 10),
          if (message.isNotEmpty)
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSuccess ? ThemeColors.white : ThemeColors.error,
              ),
            ),
        ],
      ),
    );
  }
}
