import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/features/auth/presentation/widgets/primary_button.dart';

void main() {
  Widget buildSubject({
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(
        body: PrimaryButton(
          text: 'Войти',
          onPressed: onPressed,
          isLoading: isLoading,
        ),
      ),
    );
  }

  testWidgets('calls onPressed when tapped', (tester) async {
    var taps = 0;

    await tester.pumpWidget(buildSubject(onPressed: () => taps++));
    await tester.tap(find.text('Войти'));

    expect(taps, 1);
  });

  testWidgets('does not call onPressed while loading', (tester) async {
    var taps = 0;

    await tester.pumpWidget(
      buildSubject(onPressed: () => taps++, isLoading: true),
    );
    await tester.tap(find.byType(FilledButton));

    expect(taps, 0);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
