import 'package:json_annotation/json_annotation.dart';

part 'history_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class HistoriesResponse {
  String? result;
  int? count;
  List<HistoryResponse>? rows;
  double? sumTotalPrice;

  HistoriesResponse(this.result, this.count, this.rows, this.sumTotalPrice);

  factory HistoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoriesResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HistoryResponse {
  int? ticketId;
  String? namePersonCreate;
  String? noCar;
  String? nameTicket;
  String? createdAt;
  double? totalPrice;
  int? noPrint;

  HistoryResponse(
      {this.ticketId,
      this.namePersonCreate,
      this.noCar,
      this.nameTicket,
      this.createdAt,
      this.noPrint,
      this.totalPrice});

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);
}
