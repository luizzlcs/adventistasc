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
  AutoRefreshingAuthClient? _cachedClient;

  Future<bool> verifyCredentials() async {
    try {
      final credentials = ServiceAccountCredentials.fromJson(_credentials);
      
      // Tenta criar um cliente e fazer uma chamada simples
      final client = await clientViaServiceAccount(
        credentials,
        [sheets.SheetsApi.spreadsheetsScope],
      );
      
      final sheetsApi = sheets.SheetsApi(client);
      await sheetsApi.spreadsheets.get(_spreadsheetId);
      
      client.close();
      return true;
    } catch (e) {
      log('Erro na verificação de credenciais: $e');
      return false;
    }
  }

  Future<AutoRefreshingAuthClient> _getAuthClient() async {
    try {
      if (_cachedClient != null) {
        return _cachedClient!;
      }

      final credentials = ServiceAccountCredentials.fromJson(_credentials);
      _cachedClient = await clientViaServiceAccount(
        credentials,
        [sheets.SheetsApi.spreadsheetsScope],
      );
      
      return _cachedClient!;
    } catch (e) {
      log('Erro ao obter cliente autenticado: $e');
      throw Exception('Falha na autenticação: $e');
    }
  }

  Future<sheets.SheetsApi> _getSheetsApi() async {
    final client = await _getAuthClient();
    return sheets.SheetsApi(client);
  }

  Future<List<dynamic>?> getValues(String range) async {
    try {
      final sheetsApi = await _getSheetsApi();
      final response = await sheetsApi.spreadsheets.values.get(_spreadsheetId, range);
      return response.values;
    } catch (e) {
      if (e.toString().contains('invalid_grant')) {
        log('Erro de credenciais inválidas: $e');
        // Limpa o cliente em cache para forçar uma nova autenticação
        _cachedClient?.close();
        _cachedClient = null;
      }
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
      if (e.toString().contains('invalid_grant')) {
        log('Erro de credenciais inválidas: $e');
        _cachedClient?.close();
        _cachedClient = null;
      }
      log('Erro ao atualizar valores: $e');
      throw Exception('Falha ao atualizar valores: $e');
    }
  }

  void dispose() {
    _cachedClient?.close();
  }
}