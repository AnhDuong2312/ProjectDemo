import '../domain/adapter/render_pdf_adapter.dart';
import 'render_pdf_provider.dart';

class RenderPdfRepository implements IRenderPdfRepository {
  final RenderPdfProvider provider;

  RenderPdfRepository({required this.provider});

  @override
  Future getPdf(String? ticketId, String? ticketDraftItemId) async {
    Map<String, dynamic> params = {
      "ticketId": ticketId,
      'ticketDraftItemId': ticketDraftItemId
    };

    final response = await provider.getPdf('ticket/print', params);
    return response;
  }

  @override
  Future getPdfDraftTicket(String id) async {
    Map<String, dynamic> params = {'ticketDraftItemId': id};
    final response =
        await provider.getPdfDraftTicket('ticket/draft-item/export', params);
    return response;
  }

  @override
  Future getPdfView(
    String? ticketId,
  ) async {
    final response = await provider.getPdfView(
      'ticket/export-by-id/$ticketId',
    );
    return response;
  }

  @override
  Future exportPdf(
    String? ticketId,
  ) async {
    final response = await provider.getPdfView(
      'invoice/export/$ticketId',
    );
    return response;
  }
}
