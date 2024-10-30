import 'ds_log_entity.dart';

class ListLogViewModel {
  final int? logAmount;
  final double? total;
  final List<DSLogEntity> logs;

  ListLogViewModel({this.logAmount, this.total, required this.logs});
}
