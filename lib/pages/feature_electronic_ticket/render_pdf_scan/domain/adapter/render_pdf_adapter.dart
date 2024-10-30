abstract class IRenderPdfRepository {
  Future<dynamic> getPdf(String? ticketId, String? ticketDraftItemId);
  Future<dynamic> getPdfView(
    String? ticketId,
  );
  Future<dynamic> getPdfDraftTicket(String id);
  Future<dynamic> exportPdf(
    String? ticketId,
  );
}
