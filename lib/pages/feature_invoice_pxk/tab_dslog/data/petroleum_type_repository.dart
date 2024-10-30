import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_dslog/data/response/list_petroleum_type_response.dart';

import '../../tab_petroleum/data/mapper/tab_petroleum_mapper.dart';
import '../../tab_petroleum/data/response/production_response.dart';
import '../../tab_petroleum/domain/enties/type_petroleum_entity.dart';
import 'petroleum_type_provider.dart';

abstract class IPetroleumTypeRepository {
  Future<List<String>> getProducts(Map<String, dynamic> params);
}

class PetroleumTypeRepository implements IPetroleumTypeRepository {
  final IPetroleumTypeProvider provider;

  PetroleumTypeRepository({required this.provider});

  @override
  Future<List<String>> getProducts(Map<String, dynamic> params) async {
    final response = await provider.getProducts('data-log/productName', params);
    final dataModel = ListPetroleumTypeResponse.fromJson(response);
    if (dataModel.data == null) {
      return [];
    }
    return dataModel.data!.productNames ?? [];
  }
}
