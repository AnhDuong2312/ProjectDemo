class SystemFormatNumberEntity {
  ///số lượng
  final int quantity;

  ///đơn giá + đơn giá sau thuế
  final int unitPrice;

  ///thành tiền + thành tiền sau thuế: tổng tiền trong danh sách hàng hoá
  final int totalAmount;

  ///tổng tiền + tổng tiền sau thuế
  final int totalCost;

  SystemFormatNumberEntity(
      {required this.quantity,
      required this.unitPrice,
      required this.totalAmount,
      required this.totalCost});
}
