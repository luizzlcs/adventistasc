import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;

class CounterRepository {
  final Map<String, String> _credentials = {
    "type": dotenv.env['TYPE']!,
    "project_id": dotenv.env['PROJECT_ID']!,
    "private_key_id": dotenv.env['PRIVATE_KEY_ID']!,
    "private_key": dotenv.env['PRIVATE_KEY']!.replaceAll(r'\n', '\n'),
    "client_email": dotenv.env['CLIENT_EMAIL']!,
    "client_id": dotenv.env['CLIENT_ID']!,
    "auth_uri": dotenv.env['AUTH_URI']!,
    "token_uri": dotenv.env['TOKEN_URI']!,
    "auth_provider_x509_cert_url": dotenv.env['AUTH_PROVIDER_X509_CERT_URL']!,
    "client_x509_cert_url": dotenv.env['CLIENT_X509_CERT_URL']!,
    "universe_domain": dotenv.env['UNIVERSE_DOMAIN']!,
  };

  final String _spreadsheetId = dotenv.env['SPREADSHEET_ID']!;

  Future<sheets.SheetsApi> _getSheetsApi() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(_credentials),
      [sheets.SheetsApi.spreadsheetsScope],
    );
    return sheets.SheetsApi(client);
  }

  Future<List<dynamic>?> getValues(String range) async {
    try {
      final sheetsApi = await _getSheetsApi();
      final response = await sheetsApi.spreadsheets.values.get(_spreadsheetId, range);
      return response.values;
    } catch (e) {
      log('Erro ao obter valores: $e');
      return null;
    }
  }

  Future<void> updateValues(String range, List<List<dynamic>> values) async {
    try {
      final sheetsApi = await _getSheetsApi();
      await sheetsApi.spreadsheets.values.update(
        sheets.ValueRange(values: values),
        _spreadsheetId,
        range,
        valueInputOption: 'RAW',
      );
    } catch (e) {
      log('Erro ao atualizar valores: $e');
    }
  }
}
