class SerialEntity {
  final int? id;
  final double? price;
  final String? name;
  final String? symbol;
  final double? rateTax;

  SerialEntity(
      {this.id, this.price, this.name, this.symbol, this.rateTax = 0.0});

  @override
  String toString() {
    // TODO: implement toString
    return symbol!;
  }
}
