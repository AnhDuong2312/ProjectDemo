class TypePetroleumEntity {
  final int id;
  final String name;
  final double price;
  final String unitName;
  final double vat;
  final String code;
  final String? active;

  TypePetroleumEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.unitName,
    required this.vat,
    required this.code,
    this.active,
  });
}
