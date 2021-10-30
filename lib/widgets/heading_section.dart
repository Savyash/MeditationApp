import 'package:flutter/material.dart';
import 'package:meditation_app/utils/app_theme.dart';
import 'package:meditation_app/utils/string_utils.dart';

class HeadingSection extends StatelessWidget {
  final String? title;
  final Function()? onTap;

  HeadingSection({
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 30, 12, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Text(
                StringUtils.seeAllBtn,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.bottomNavBarSelectedColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
