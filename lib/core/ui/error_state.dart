import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guide_manager/app/theme.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({required this.title, this.onRetry, super.key});

  final String title;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/images/error.svg'),
        const SizedBox(height: 35),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        if (onRetry != null)
          TextButton(
            onPressed: onRetry,
            child: Text(
              'Повторить',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: colors.link),
            ),
          ),
      ],
    );
  }
}
