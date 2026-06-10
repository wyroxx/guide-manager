import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/core/ui/empty_state.dart';
import 'package:guide_manager/core/ui/error_state.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(body: child),
    );
  }

  testWidgets('state widgets render content and retry behavior', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const AppEmptyState(
          title: 'Нет заявок',
          subtitle: 'Они появятся позже',
        ),
      ),
    );

    expect(find.text('Нет заявок'), findsOneWidget);
    expect(find.text('Они появятся позже'), findsOneWidget);

    var retryCount = 0;

    await tester.pumpWidget(
      wrap(
        AppErrorState(
          title: 'Не удалось загрузить',
          onRetry: () => retryCount++,
        ),
      ),
    );

    expect(find.text('Не удалось загрузить'), findsOneWidget);
    expect(find.text('Повторить'), findsOneWidget);

    await tester.tap(find.text('Повторить'));

    expect(retryCount, 1);

    await tester.pumpWidget(
      wrap(const AppErrorState(title: 'Не удалось загрузить')),
    );

    expect(find.text('Повторить'), findsNothing);
  });
}
