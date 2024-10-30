import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common/api_error/api_error.dart';
import '../../../../../common/mixins/controller_mixin.dart';
import '../../../tab_petroleum/domain/enties/type_petroleum_entity.dart';
import '../../data/ds_log_repository.dart';
import '../../data/petroleum_type_repository.dart';
import '../../domain/entity/ds_log_entity.dart';
import '../../domain/entity/invoice_state_entity.dart';
import '../../domain/entity/nozzle_entity.dart';
import '../../domain/entity/station_entity.dart';

class DSLogController extends GetxController with ControllerMixin {
  final IPetroleumTypeRepository petroleumTypeRepository;
  final IDSLogRepository repository;

  var startDateForm = "";
  var startDateController = TextEditingController();
  var endDateForm = "";
  var endDateController = TextEditingController();

  // load more
  var isLoadMore = false;

  var listLog = <DSLogEntity>[].obs;
  var total = 0.0.obs;
  var logAmount = 0.obs;
  var page = 1;

  // Trạm xăng
  var listStation = <StationEntity>[].obs;
  var selectedStation =
      StationEntity(code: 'ALL_STATION', name: 'Tất cả cửa hàng').obs;

  // Cột bơm
  var listNozzle = <NozzleEntity>[].obs;
  var selectedNozzle =
      NozzleEntity(code: 'ALL_NOZZLE', name: 'Tất cả cột bơm').obs;

  // Loại nhiên liệu
  var listPetroleumType = <String>[].obs;
  var selectedPetroleumType = 'Tất cả nhiên liệu'.obs;

  // Trạng thái hoá đơn
  var listInvoiceState = <InvoiceStateEntity>[].obs;
  var selectedInvoiceState =
      InvoiceStateEntity(code: 'ALL_INVOICE', name: 'Tất cả hoá đơn').obs;

  DSLogController(this.petroleumTypeRepository, this.repository);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    startDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    endDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

    listStation.value = [
      StationEntity(code: 'ALL_STATION', name: 'Tất cả cửa hàng')
    ];
    selectedStation.value = listStation[0];

    listNozzle.value = [
      NozzleEntity(code: 'ALL_NOZZLE', name: 'Tất cả cột bơm')
    ];
    selectedNozzle.value = listNozzle[0];

    listPetroleumType.value = ['Tất cả nhiên liệu'];
    selectedPetroleumType.value = listPetroleumType[0];

    listInvoiceState.value = [
      InvoiceStateEntity(code: 'ALL_INVOICE', name: 'Tất cả hoá đơn'),
      InvoiceStateEntity(code: 'NOT_CREATE_INVOICE', name: 'Chưa xuất hóa đơn'),
      InvoiceStateEntity(code: 'CREATED_INVOICE', name: 'Chưa phát hành'),
      InvoiceStateEntity(code: 'RELEASED_INVOICE', name: 'Đã phát hành'),
      InvoiceStateEntity(code: 'RELEASING_INVOICE', name: 'Đang xuất hóa đơn'),
      InvoiceStateEntity(code: 'RELEASE_ERROR', name: 'Lỗi phát hành'),
      InvoiceStateEntity(code: 'CANCELLED', name: 'Đã hủy'),
    ];
    selectedInvoiceState.value = listInvoiceState[0];

    fetchInitData();
  }

  fetchInitData() async {
    await fetchTypePetroleum();
    await fetchStations();
    await fetchLogs();
  }

  Future<void> fetchLogs() async {
    page = 1;
    isLoadMore = true;
    showLoading();
    try {
      var param = {
        "stationCode": selectedStation.value.code != 'ALL_STATION'
            ? selectedStation.value.code
            : null,
        "nozzleCode": selectedNozzle.value.code != 'ALL_NOZZLE'
            ? selectedNozzle.value.code
            : null,
        "startDate": startDateForm,
        "endDate": endDateForm,
        "status": selectedInvoiceState.value.code != 'ALL_INVOICE'
            ? selectedInvoiceState.value.code
            : null,
        "productName": selectedPetroleumType.value != 'Tất cả nhiên liệu'
            ? selectedPetroleumType.value
            : null,
        "limit": "10",
        "page": page.toString()
      };

      final response = await repository.fetchLogs(param);
      logAmount.value = response.logAmount ?? 0;
      total.value = response.total ?? 0;
      listLog.value = response.logs;
      if (response.logs.length < 10) {
        isLoadMore = false;
      }
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
    }
  }

  Future<void> loadMoreLogs() async {
    if (isLoadMore == false) return;
    page++;
    try {
      var param = {
        "stationCode": selectedStation.value.code != 'ALL_STATION'
            ? selectedStation.value.code
            : null,
        "nozzleCode": selectedNozzle.value.code != 'ALL_NOZZLE'
            ? selectedNozzle.value.code
            : null,
        "startDate": startDateForm,
        "endDate": endDateForm,
        "status": selectedInvoiceState.value.code != 'ALL_INVOICE'
            ? selectedInvoiceState.value.code
            : null,
        "productName": selectedPetroleumType.value != 'Tất cả nhiên liệu'
            ? selectedPetroleumType.value
            : null,
        "limit": "10",
        "page": page.toString()
      };

      final response = await repository.fetchLogs(param);
      logAmount.value = response.logAmount ?? 0;
      total.value = response.total ?? 0;
      listLog.value = listLog.value + response.logs;
      if (response.logs.length < 10) {
        isLoadMore = false;
      }
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
    }
  }

  fetchTypePetroleum() async {
    try {
      var data = await petroleumTypeRepository.getProducts({});
      listPetroleumType.value = ['Tất cả nhiên liệu'] + data;
      selectedPetroleumType.value = listPetroleumType[0];
    } on Exception catch (e) {
      showErrorAlert(e.toString(), () {});
    }
  }

  Future<void> fetchStations() async {
    try {
      final response = await repository.fetchStations({});
      listStation.value = [
            StationEntity(code: 'ALL_STATION', name: 'Tất cả cửa hàng')
          ] +
          response;
      selectedStation.value = listStation[0];

      listNozzle.value = selectedStation.value.nozzles ??
          [NozzleEntity(code: 'ALL_NOZZLE', name: 'Tất cả cột bơm')];
      selectedNozzle.value = listNozzle[0];
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
    }
  }

  void updateNozzle() {
    listNozzle.value = selectedStation.value.nozzles ??
        [NozzleEntity(code: 'ALL_NOZZLE', name: 'Tất cả cột bơm')];
    selectedNozzle.value = listNozzle[0];
  }

  clearForm() {
    startDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    endDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
}
