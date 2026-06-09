import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    this.subtitle,
    this.assetPath = 'assets/images/empty_excursions.svg',
    this.padding = EdgeInsets.zero,
    this.imageTitleSpacing = 30,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String assetPath;
  final EdgeInsetsGeometry padding;
  final double imageTitleSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(assetPath),
          SizedBox(height: imageTitleSpacing),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
