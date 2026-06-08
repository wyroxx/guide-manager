enum GuideLevel {
  trainee('trainee', 'стажер'),
  junior('junior', 'начинающий'),
  middle('middle', 'средний'),
  senior('senior', 'старший');

  final String nameRus;
  final String nameEng;
  const GuideLevel(this.nameEng, this.nameRus);
  factory GuideLevel.fromString(String string) {
    switch (string) {
      case 'trainee':
        return GuideLevel.trainee;
      case 'junior':
        return GuideLevel.junior;
      case 'middle':
        return GuideLevel.middle;
      case 'senior':
        return GuideLevel.senior;
      default:
        return GuideLevel.trainee;
    }
  }
}

enum PaymentStatus {
  paid('оплачено'),
  unpaid('не оплачено');

  final String string;
  const PaymentStatus(this.string);
}

enum ApplicationStatus {
  pending('pending', 'ожидает'),
  accepted('accepted', 'принята'),
  rejected('rejected', 'отклонена');

  final String statusEng;
  final String statusRus;
  const ApplicationStatus(this.statusEng, this.statusRus);
  factory ApplicationStatus.fromString(String string) {
    switch (string) {
      case 'pending':
        return ApplicationStatus.pending;
      case 'accepted':
        return ApplicationStatus.accepted;
      case 'rejected':
        return ApplicationStatus.rejected;
      default:
        return ApplicationStatus.pending;
    }
  }
}
