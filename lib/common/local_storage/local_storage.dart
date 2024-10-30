import 'package:get_storage/get_storage.dart';

class StorageKey {
  static const String accessToken = 'access_token';
  static const String isAutoLogin = 'is_auto_login';
  static const String printerName = 'printer_name';
  static const String printerMacAddress = 'printer_mac_address';
  static const String paperSize = 'paper_size';
  static const String userLogin = 'user_login';
  static const String userPassword = 'user_password';
  static const String userCode = 'user_code';
  static const String fullName = 'full_name';
  static const String taxCode = 'tax_code';
  static const String userAddress = 'user_address';
  static const String accountId = 'account_id';
  static const String companyId = 'company_id';
}

// Pub: https://pub.dev/packages/get_storage

class LocalStorage {
  // Explain: Khi khai bao nhu phia duoi thi no se tu sinh ra : GetStorage de luu tru du lieu
  final accessToken = ''.val(StorageKey.accessToken);
  final isAutoLogin = false.val(StorageKey.isAutoLogin);
  final printerName = ''.val(StorageKey.printerName);
  final printerMacAddress = ''.val(StorageKey.printerMacAddress);
  final userLogin = ''.val(StorageKey.userLogin);
  final userPassword = ''.val(StorageKey.userPassword);
  final userCode = ''.val(StorageKey.userCode);
  final fullName = ''.val(StorageKey.fullName);
  final taxCode = ''.val(StorageKey.taxCode);
  final userAddress = ''.val(StorageKey.userAddress);
  final accountId = (-1).val(StorageKey.accountId);
  final companyId = (-1).val(StorageKey.companyId);

  // paper size = 58 or 80
  final paperSize = 58.val(StorageKey.paperSize);
}
