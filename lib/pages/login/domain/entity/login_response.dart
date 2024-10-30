import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
class LoginResponse {
  String? accessToken;
  AccountResponse? account;
  LoginResponse(this.accessToken, this.account);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AccountResponse {
  String? fullname;
  String? taxCode;
  String? address;
  int? accountId;
  int? companyId;

  AccountResponse(this.fullname, this.taxCode, this.address, this.accountId,
      this.companyId);

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);
}
