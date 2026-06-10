import 'package:flutter_test/flutter_test.dart';
import 'package:guide_manager/core/enums.dart';

void main() {
  group('GuideLevel', () {
    test('fromString parses known values and falls back to trainee', () {
      expect(GuideLevel.fromString('middle'), GuideLevel.middle);
      expect(GuideLevel.fromString('senior'), GuideLevel.senior);
      expect(GuideLevel.fromString('unknown'), GuideLevel.trainee);
    });
  });

  group('ApplicationStatus', () {
    test('fromString parses known values and falls back to pending', () {
      expect(
        ApplicationStatus.fromString('accepted'),
        ApplicationStatus.accepted,
      );
      expect(
        ApplicationStatus.fromString('rejected'),
        ApplicationStatus.rejected,
      );
      expect(
        ApplicationStatus.fromString('unknown'),
        ApplicationStatus.pending,
      );
    });

    test('priority sorts pending before accepted and rejected', () {
      final statuses = [
        ApplicationStatus.rejected,
        ApplicationStatus.accepted,
        ApplicationStatus.pending,
      ]..sort((a, b) => a.priority.compareTo(b.priority));

      expect(statuses, [
        ApplicationStatus.pending,
        ApplicationStatus.accepted,
        ApplicationStatus.rejected,
      ]);
    });
  });
}
