import 'dart:developer';
import 'package:flutter/material.dart';
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

  static const _credentials = {
    "type": "service_account",
    "project_id": "bios-instagram",
    "private_key_id": "b455ff6e3a9a51530fc34c25022a6a3d4adc8085",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCyybs+JAKk1jxa\n2BKNhGGTIi6cNG1A28vea7Y1Y/RQJ4qexWgvl2OBnA3ErBAfWjIT5EXbrOWSHeim\nUC5brTLFakuTGlqSFZsgj95ecfcPrJrSzDG4yY17zd+QNvPLlkqNjPQYooqT/CJG\n4aspn+EckDIMG0MaPthGtr/Vmt1IvepymcficJnqUCassSP/f3GwxPMKArBRWdwi\nOn5Wyv2W7ErpMbcZN9Dff2xdECzkItqgVsVKGYaWi9foySF690qHW0uvfQuKRHdU\nP+9M+mgtVSDtZEQ50BZSxDHJCQQ2wAz7cvQgoFhaeIPG3iHhSR34uJ8ujGM8Nf/J\nCjd5aUSfAgMBAAECggEAErKyWG9fr2mQalfKqO49XivnAAMjofLawWo2ZiML/A4G\nm1A98yw8BeQSNI1iKkU+k4H+JFlSsRNbr3kXQBM/ChJx0PKiokCMNr2VHf+BPSxq\nDL26PX8mwtnnFagJmzMenOsu5ByrrYpi81LKmdHUsy4Jbeaz/9yutcaLDYXiuqak\n4c+hFq1EY2TRLpSJk3cT3WbTPwNPbUOi+kYwKqFyAbr/O+JaF8W1QOLevw8KnZnv\nA0qHpIzz+Fl4wU33Y+tQovHqVBOu2ttUHWw8HtYnEhY2rUzUkUCUANN9e3n8rYjL\ntWKlAzcuwNx3fMcB34SoXzL6iGR+wZJOxHfiyVvioQKBgQD1NaoO6/A0kRVWL3Qd\ngWTtCCJh0mpocECzYB19iNtLX1RZqmWLqZmE3EcmrmUeKfWPli/Ut91uNhkTmcga\n3RuzYrw3pUYdTiRwQvzCCWfPN4JE4NiQ9sTcpNXWXnC2g77+HhQsua9yKY5KS1eD\nfi/3sl6Y/uhMNBkwspHu/mAexwKBgQC6p9B2xDbs1NCRdtMX+PZQM2dOJE0dgJ6k\nBKDVcoRTwFVZC/ESoXOHmglMjrRCBdQTyjmnn28+8s7oD7SUs7gDE36JK9RdhOB+\n3A/y9Q1Chblux51758qP6BE7HAeHA0CoJOumY7i5qu4+0IRadt/Ih9BcQ9i2EULR\nrF7DZE0zaQKBgQCfny1yxTf6oC9JiV6HDoJKoq7vCvBlyBz2J61K2NoYOJhKPlgY\nEHF1QYe3sHL2rc3CiLveN0qXwfOVBNh0VFcB8VYgyx/XV9T0l0a+cSz4gWP1voB7\n7Ye9MjhZceThiuW7uozbiIyjPlX4Gw9+85f6IEzgP5+sa4WyY6wH7eNYZQKBgC1a\nYTi6bG4XN6ZgrOICSDcshkliYKpueh14UmwKq0R+Uz6TvDu+pwen0eKcOghgyisU\n0/V6s9kjvkp8pnALSwbUUcaas7sVckbgya9LA7HKNEhKkGVu6LUWujkWkm2nyKoS\nbn+7c0MJ2WHB4Kbqg22CMop4oct7XjT8IPpxAKEhAoGBANKlPwk4xMi1MohU+a2l\nYQRJnfDmCrgxMLKi3lftvct2emD2sut8sBPQ1ToUpx6ywNmLulyU+t2Kn0GfWhSY\nBcKxI6iKZvu5Nej0QAIok7/DqokrQD/u7bqZkXLhx6xa1sbel8nL2h7mYktVj+0Z\nlXvhlFzfnEiRgC7sRkKjq4F9\n-----END PRIVATE KEY-----\n",
    "client_email": "flutter-sheets@bios-instagram.iam.gserviceaccount.com",
    "client_id": "100223465449383188781",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/flutter-sheets%40bios-instagram.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };

  Map<String, String> get credentials => _credentials;

  static const _spreadsheetId = '1uMBYDWLZCk3UuaKnShCvf4ESXeRUGj7idQL5F_yCFkc';

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
        ServiceAccountCredentials.fromJson(_credentials),
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
        ServiceAccountCredentials.fromJson(_credentials),
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
        ServiceAccountCredentials.fromJson(_credentials),
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
        ServiceAccountCredentials.fromJson(_credentials),
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
