class DSLogEntity {
  final int? id;
  final String? petroleumType;
  final double? price;
  final double? amount;
  final double? totalPrice;
  final String? timeCreated;
  final String? nozzle;
  final String? status;
  final bool? isMarked;

  DSLogEntity(
      {this.id,
      this.petroleumType,
      this.price,
      this.amount,
      this.timeCreated,
      this.totalPrice = 0,
      this.nozzle,
      this.status,
      this.isMarked});

  // Kiểm tra trạng thái hoá đơn để hiển thị button create hoá đơn??
  bool canCreateInvoice() {
    if (status == 'NOT_CREATE_INVOICE' || status == 'RELEASE_ERROR') {
      return true;
    }
    return false;
  }

  String statusTitle() {
    if (status == 'NOT_CREATE_INVOICE') {
      return 'Chưa xuất hóa đơn';
    }
    if (status == 'CREATED_INVOICE') {
      return 'Chưa phát hành';
    }
    if (status == 'RELEASED_INVOICE') {
      return 'Đã phát hành';
    }
    if (status == 'MARKED') {
      return 'Đã đánh dấu';
    }
    if (status == 'RELEASING_INVOICE') {
      return 'Đang xuất hóa đơn';
    }
    if (status == 'RELEASE_ERROR') {
      return 'Lỗi phát hành';
    }
    if (status == 'CANCELLED') {
      return 'Đã hủy';
    }
    return '';
  }
}
