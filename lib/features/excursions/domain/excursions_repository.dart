import 'package:guide_manager/features/excursions/domain/excursion.dart';

abstract interface class ExcursionsRepository {
  Future<List<Excursion>> getExcursions();
}
