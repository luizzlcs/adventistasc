import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;

// Enumeração para identificar cada botão
enum ButtonType {
  retiro,
  tv,
  youtube,
  peca,
  localizacao,
  dizimar,
  estude,
  facebook,
  insta,
  site,
  desb,
  avt,
  banda
}

class CounterController with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Mapa para armazenar contadores
  final Map<ButtonType, int> _counters = {};
  // Mapa para armazenar datas
  final Map<ButtonType, DateTime> _dates = {};

  // Data e contador de acesso à página
  DateTime _pageAccessDate = DateTime.now();
  int _pageAccessCount = 0;

  DateTime get pageAccessDate => _pageAccessDate;
  int get pageAccessCount => _pageAccessCount;

  // Getters para contadores e datas
  int getCount(ButtonType type) => _counters[type] ?? 0;
  DateTime? getLastDate(ButtonType type) => _dates[type];

  // Mapeamento de ButtonType para linha na planilha
  final Map<ButtonType, int> _rowMapping = {
    ButtonType.retiro: 3, // Começa na linha 3 (A3:B4)
    ButtonType.tv: 5, // A5:B6
    ButtonType.youtube: 7, // A7:B8
    ButtonType.peca: 9, // A9:B10
    ButtonType.localizacao: 11, // A11:B12
    ButtonType.dizimar: 13, // A13:B14
    ButtonType.estude: 15, // A15:B16
    ButtonType.facebook: 17, // A17:B18
    ButtonType.insta: 19, // A19:B20
    ButtonType.site: 21, // A21:B22
    ButtonType.desb: 23, // A23:B24
    ButtonType.avt: 25, // A25:B26
    ButtonType.banda: 27, // A27:B28
  };

  
  static final Map<String, String> _credentials = {
    "type": dotenv.env['TYPE']!,
    "project_id": dotenv.env['PROJECT_ID']!,
    "private_key_id": dotenv.env['PRIVATE_KEY_ID']!,
    "private_key": dotenv.env['PRIVATE_KEY']!.replaceAll(r'\n', '\n'), // Ajuste para multiline
    "client_email": dotenv.env['CLIENT_EMAIL']!,
    "client_id": dotenv.env['CLIENT_ID']!,
    "auth_uri": dotenv.env['AUTH_URI']!,
    "token_uri": dotenv.env['TOKEN_URI']!,
    "auth_provider_x509_cert_url": dotenv.env['AUTH_PROVIDER_X509_CERT_URL']!,
    "client_x509_cert_url": dotenv.env['CLIENT_X509_CERT_URL']!,
    "universe_domain": dotenv.env['UNIVERSE_DOMAIN']!,
  };

  static final String _spreadsheetId = dotenv.env['SPREADSHEET_ID']!;

  Map<String, String> get credentials => _credentials;

  
  // Novo método que combina carregamento e atualização
  Future<void> initializeAndIncrement() async {
    await loadAllData(); // Primeiro carrega os dados atuais
    await incrementPageAccess(); // Depois incrementa e atualiza
    notifyListeners(); // Notifica os listeners sobre a mudança
  }

  // Carrega todos os dados da planilha
  Future<void> loadAllData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(credentials),
        [sheets.SheetsApi.spreadsheetsScope],
      );

      final sheetsApi = sheets.SheetsApi(client);

      // Carrega dados de acesso à página (B1:B2)
      final pageAccessResponse = await sheetsApi.spreadsheets.values.get(
        _spreadsheetId,
        'B1:B2',
      );

      if (pageAccessResponse.values != null &&
          pageAccessResponse.values!.isNotEmpty) {
        _pageAccessDate =
            DateTime.parse(pageAccessResponse.values![0][0].toString());
        _pageAccessCount =
            int.parse(pageAccessResponse.values![1][0].toString());
      }

      // Carrega dados de todos os botões
      for (var type in ButtonType.values) {
        final row = _rowMapping[type]!;
        final response = await sheetsApi.spreadsheets.values.get(
          _spreadsheetId,
          'B$row:B${row + 1}',
        );

        if (response.values != null && response.values!.isNotEmpty) {
          _dates[type] = DateTime.parse(response.values![0][0].toString());
          _counters[type] = int.parse(response.values![1][0].toString());
        }
      }

      client.close();
    } catch (e) {
      log('Erro ao carregar dados: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Incrementa contador específico
  Future<void> incrementCounter(ButtonType type) async {
    _isLoading = true;
    notifyListeners();

    try {
      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(credentials),
        [sheets.SheetsApi.spreadsheetsScope],
      );

      final sheetsApi = sheets.SheetsApi(client);
      final dateNow = DateTime.now();
      final row = _rowMapping[type]!;
      final countCell = 'B${row + 1}';

      // 🟢 Passo 1: Ler o valor atual da célula
      final response =
          await sheetsApi.spreadsheets.values.get(_spreadsheetId, countCell);

      int currentCount = 0; // Valor padrão

      if (response.values != null &&
          response.values!.isNotEmpty &&
          response.values![0].isNotEmpty) {
        final rawValue = response.values![0][0];

        // Converter apenas se não for nulo e for uma String válida
        if (rawValue is String) {
          currentCount = int.tryParse(rawValue) ?? 0;
        } else if (rawValue is int) {
          currentCount = rawValue;
        }
      }

      int newCount = currentCount + 1;

      // Debugging antes da atualização
      debugPrint('Linha: $row');
      debugPrint('Valor atual: $currentCount');
      debugPrint('Novo valor: $newCount');

      // 🟢 Passo 2: Atualizar o Google Sheets com o novo valor
      await sheetsApi.spreadsheets.values.update(
        sheets.ValueRange(values: [
          [dateNow.toIso8601String()], // Atualiza data
          [newCount] // Atualiza contador somado +1
        ]),
        _spreadsheetId,
        'B$row:B${row + 1}',
        valueInputOption: 'RAW',
      );

      debugPrint('Atualização concluída!');

      // Atualiza estado local
      _dates[type] = dateNow;
      _counters[type] = newCount;

      client.close();
    } catch (e, stackTrace) {
      debugPrint('Erro ao atualizar contador: $e\n$stackTrace');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCounterByType(ButtonType type) async {
    _isLoading = true;
    notifyListeners();

    try {
      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(credentials),
        [sheets.SheetsApi.spreadsheetsScope],
      );

      final sheetsApi = sheets.SheetsApi(client);

      // 🔹 Pegamos a linha correspondente ao tipo do botão
      final row = _rowMapping[type];
      if (row == null) return;

      final countCell = 'B${row + 1}';
      final dateCell = 'B$row';

      int countValue = 0;
      DateTime dateValue = DateTime.now();

      // 🟢 Buscar o contador
      final countResponse =
          await sheetsApi.spreadsheets.values.get(_spreadsheetId, countCell);
      if (countResponse.values != null &&
          countResponse.values!.isNotEmpty &&
          countResponse.values![0].isNotEmpty) {
        final rawValue = countResponse.values![0][0];

        if (rawValue is String) {
          countValue = int.tryParse(rawValue) ?? 0;
        } else if (rawValue is int) {
          countValue = rawValue;
        }
      }

      // 🟢 Buscar a data
      final dateResponse =
          await sheetsApi.spreadsheets.values.get(_spreadsheetId, dateCell);
      if (dateResponse.values != null &&
          dateResponse.values!.isNotEmpty &&
          dateResponse.values![0].isNotEmpty) {
        final rawDate = dateResponse.values![0][0];

        if (rawDate is String) {
          try {
            dateValue = DateTime.parse(rawDate);
          } catch (e) {
            debugPrint('Erro ao converter data: $e');
          }
        }
      }

      // 🔹 Atualizar o estado com os valores obtidos
      _counters[type] = countValue;
      _dates[type] = dateValue;

      client.close();
    } catch (e, stackTrace) {
      debugPrint('Erro ao buscar contador para $type: $e\n$stackTrace');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Incrementa contador de acesso à página
  Future<void> incrementPageAccess() async {
    _isLoading = true;
    notifyListeners();

    try {
      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(credentials),
        [sheets.SheetsApi.spreadsheetsScope],
      );

      final sheetsApi = sheets.SheetsApi(client);
      final dateNow = DateTime.now();

      await sheetsApi.spreadsheets.values.update(
        sheets.ValueRange(
          values: [
            [dateNow.toIso8601String()],
            [_pageAccessCount + 1]
          ],
        ),
        _spreadsheetId,
        'B1:B2',
        valueInputOption: 'RAW',
      );

      _pageAccessDate = dateNow;
      _pageAccessCount++;

      client.close();
    } catch (e) {
      log('Erro ao atualizar acesso à página: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
