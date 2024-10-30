class HistoryEntity {
  final int? id;
  final String? typeTicket;
  final String? licenceTemplate;
  final String? timeCreated;
  final String? namePersonCreate;
  final double? totalPrice;
  final int? noPrint;

  HistoryEntity(
      {this.id,
      this.typeTicket,
      this.licenceTemplate,
      this.timeCreated,
      this.namePersonCreate,
      this.totalPrice = 0,
      this.noPrint});
}
