import 'petroleum_invoice_entity.dart';

class PetroleumInvoiceViewModel {
  final int? invoiceAmount;
  final double? total;
  final List<PetroleumInvoiceEntity> invoices;

  PetroleumInvoiceViewModel(
      {this.invoiceAmount, this.total, required this.invoices});
}
