enum Environment {
  production,
  perfomance,
  development,
}

extension EnvironmentExtension on Environment {
  // String get serverURL {
  //   switch (this) {
  //     case Environment.production:
  //       return 'https://v2.vietinvoice.vn/api/v1/';
  //     case Environment.perfomance:
  //       return 'https://v2.vietinvoice.vn/api/v1/';
  //     case Environment.development:
  //       return 'https://v2.vietinvoice.vn/api/v1/';
  //   }
  // return 'https://hoadondientu.vietinvoice.vn/api/v1/';
  // }

  String get serverURL {
    /// return 'https://hoadondientu.vietinvoice.vn/api/v1/';
    ///     /// return 'https://hoadondientu.vietinvoice.vn/api/v1/';
    //     /// 'https://v2.vietinvoice.vn/api/v1/
    //     /// https://hoadondientu.vietinvoice.vn
    //     /// https://petro.vietinvoice.vn
    //     /// https://tuluc.vietinvoice.vn
    switch (this) {
      case Environment.production:
        return 'https://hoadondientu.vietinvoice.vn/api/v1/';
      case Environment.perfomance:
        return 'https://hoadondientu.vietinvoice.vn/api/v1/';
      case Environment.development:
        return 'https://hoadondientu.vietinvoice.vn/api/v1/';
    }
  }

  String get serverURLQR {
    // https://v2.vietinvoice.vn/
    // https://tracuuhoadon.vietinvoice.vn/
    // https://tracuupetro.vietinvoice.vn/
    // https://tracuutuluc.vietinvoice.vn/
    switch (this) {
      case Environment.production:
        return 'https://hoadondientu.vietinvoice.vn/api/v1/';
      case Environment.perfomance:
        return 'https://hoadondientu.vietinvoice.vn/api/v1/';
      case Environment.development:
        return 'https://hoadondientu.vietinvoice.vn/api/v1/';
    }
  }
}
