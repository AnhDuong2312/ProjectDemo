class PetroleumInvoiceEntity {
  final int? id;
  final String? companyName;
  final String? taxNumber;
  final double? totalPrice;
  final String? serial;
  final String? date;
  final String? invoiceNumber;
  final String? customerEmail;
  final String? customerName;

  PetroleumInvoiceEntity({
    this.id,
    this.companyName,
    this.taxNumber,
    this.totalPrice = 0,
    this.serial,
    this.date,
    this.invoiceNumber,
    this.customerEmail,
    this.customerName,
  });
}
