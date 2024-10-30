import '../domain/adapter/serial_adapter.dart';
import 'serial_provider.dart';

class SerialRepository implements ISerialRepository {
  final ISerialProvider provider;

  SerialRepository({required this.provider});

  @override
  Future<dynamic> getSerial() async {
    final response = await provider.getSerial('Mobile/getFields');
    return response;
  }

  @override
  Future releaseTicket(Map<String, dynamic> param) async {
    final response =
        await provider.releaseTicket('ticket/draft/hsm-sign', param);
    return response;
  }

  @override
  Future createTicketDraft(Map<String, dynamic> param) async {
    final response =
        await provider.createTicketDraft('ticket/draft/create', param);
    return response;
  }
}
