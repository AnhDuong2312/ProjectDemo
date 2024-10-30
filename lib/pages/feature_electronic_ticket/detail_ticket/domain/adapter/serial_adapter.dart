abstract class ISerialRepository{
  Future<dynamic> getSerial();
  Future<dynamic> createTicketDraft(Map<String, dynamic> param);
  Future<dynamic> releaseTicket(Map<String, dynamic> param);

}