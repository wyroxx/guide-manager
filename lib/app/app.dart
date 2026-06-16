import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/app/router.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/app/theme_controller.dart';

class GuideApp extends ConsumerWidget {
  const GuideApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Guide Manager',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return WebMobileFrame(child: child ?? const SizedBox.shrink());
      },
    );
  }
}

class WebMobileFrame extends StatelessWidget {
  const WebMobileFrame({required this.child, super.key});

  final Widget child;

  static const double maxMobileWidth = 450;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return child;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 600;

        if (!isDesktop) {
          return child;
        }

        final mediaQuery = MediaQuery.of(context);
        final framedSize = Size(maxMobileWidth, mediaQuery.size.height);

        return Material(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: SizedBox(
              width: maxMobileWidth,
              height: constraints.maxHeight,
              child: MediaQuery(
                data: mediaQuery.copyWith(size: framedSize),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
