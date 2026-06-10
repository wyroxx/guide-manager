import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/features/auth/presentation/widgets/auth_text_field.dart';

void main() {
  testWidgets('renders hint, updates text, and shows validation error', (
    tester,
  ) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: Form(
            key: formKey,
            child: AuthTextField(
              controller: controller,
              hintText: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ошибка';
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'guide@example.com');
    expect(controller.text, 'guide@example.com');

    await tester.enterText(find.byType(TextFormField), '');
    formKey.currentState!.validate();
    await tester.pump();

    expect(find.text('Ошибка'), findsOneWidget);
  });
}
