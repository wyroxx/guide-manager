import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/core/ui/snack_bar.dart';

void main() {
  testWidgets('replaces the active toast instead of stacking', (tester) async {
    late BuildContext context;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (builderContext) {
            context = builderContext;
            return const Scaffold();
          },
        ),
      ),
    );

    showAppToast(context, message: 'Первое сообщение');
    await tester.pump();

    showAppToast(context, message: 'Второе сообщение');
    await tester.pump();

    expect(find.text('Первое сообщение'), findsNothing);
    expect(find.text('Второе сообщение'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 300));
  });
}
