import 'nozzle_entity.dart';

class StationEntity {
  final String? code;
  final String? name;
  final List<NozzleEntity>? nozzles;

  StationEntity({this.code, this.name, this.nozzles});
}
