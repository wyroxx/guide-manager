import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/features/applications/presentation/applications_page.dart';
import 'package:guide_manager/features/excursions/presentation/excursions_page.dart';
import 'package:guide_manager/features/profile/data/profile_repository_impl.dart';

void main() {
  Widget wrap(Widget child) {
    return ProviderScope(
      overrides: [
        profileDataProvider.overrideWith((ref) => Stream.value(null)),
      ],
      child: MaterialApp(theme: AppTheme.light, home: child),
    );
  }

  testWidgets('calendar explains that excursions require account approval', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(wrap(const ExcursionsPage()));
    await tester.pumpAndSettle();

    expect(find.text('Экскурсии не найдены'), findsOneWidget);
    expect(find.text('Они появятся после одобрения аккаунта'), findsOneWidget);
  });

  testWidgets('applications do not query protected data before approval', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(wrap(const ApplicationsPage()));
    await tester.pumpAndSettle();

    expect(find.text('Нет доступных экскурсий'), findsOneWidget);
    expect(find.text('Они появятся после одобрения аккаунта'), findsOneWidget);

    await tester.tap(find.text('Мои заявки'));
    await tester.pumpAndSettle();

    expect(find.text('Нет доступных экскурсий'), findsOneWidget);
    expect(find.text('Они появятся после одобрения аккаунта'), findsOneWidget);
  });
}
