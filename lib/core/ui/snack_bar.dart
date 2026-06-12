import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guide_manager/app/theme.dart';

enum AppToastType { info, success, error, warning }

OverlayEntry? _activeToastEntry;

void showAppToast(
  BuildContext context, {
  required String message,
  AppToastType type = AppToastType.info,
}) {
  final overlay = Overlay.of(context);

  if (_activeToastEntry case final activeEntry?) {
    if (activeEntry.mounted) {
      activeEntry.remove();
    }
    _activeToastEntry = null;
  }

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) {
      return _AppToast(
        message: message,
        type: type,
        onDismissed: () {
          if (!identical(_activeToastEntry, entry)) return;

          if (entry.mounted) {
            entry.remove();
          }
          _activeToastEntry = null;
        },
      );
    },
  );

  _activeToastEntry = entry;
  overlay.insert(entry);
}

class _AppToast extends StatefulWidget {
  const _AppToast({
    required this.message,
    required this.type,
    required this.onDismissed,
  });

  final String message;
  final AppToastType type;
  final VoidCallback onDismissed;

  @override
  State<_AppToast> createState() => _AppToastState();
}

class _AppToastState extends State<_AppToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      reverseDuration: const Duration(milliseconds: 220),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.35), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    unawaited(_show());
  }

  Future<void> _show() async {
    await _controller.forward();
    if (!mounted) return;

    _dismissTimer = Timer(const Duration(seconds: 3), () {
      unawaited(_hide());
    });
  }

  Future<void> _hide() async {
    await _controller.reverse();
    if (!mounted) return;

    widget.onDismissed();
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Color get _color {
    final colors = context.appColors;

    return switch (widget.type) {
      AppToastType.info => colors.primary,
      AppToastType.success => colors.success,
      AppToastType.error => colors.error,
      AppToastType.warning => colors.warning,
    };
  }

  IconData get _icon {
    return switch (widget.type) {
      AppToastType.info => CupertinoIcons.info_circle_fill,
      AppToastType.success => Icons.check,
      AppToastType.error => Icons.close,
      AppToastType.warning => CupertinoIcons.exclamationmark,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(_icon, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
