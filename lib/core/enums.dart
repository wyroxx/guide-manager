enum GuideLevel {
  trainee('стажер'),
  junior('начинающий'),
  middle('средний'),
  senior('старший');

  final String name;
  const GuideLevel(this.name);
}

enum PaymentStatus {
  paid('оплачено'), unpaid('не оплачено');
  final String string;
  const PaymentStatus(this.string);
}
