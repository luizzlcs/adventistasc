
import 'package:gsheets/gsheets.dart';

class GoogleSheetsRepository {
  final GSheets _gsheets;
  final String _spreadsheetId;
  final String _worksheetTitle;

  GoogleSheetsRepository({
    required Map<String, String> credentials,
    required String spreadsheetId,
    required String worksheetTitle,
  })  : _gsheets = GSheets(credentials),
        _spreadsheetId = spreadsheetId,
        _worksheetTitle = worksheetTitle;

  Future<List<List<String>>> fetchSheetData() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      final worksheet = spreadsheet.worksheetByTitle(_worksheetTitle); // antes do spreadsheet tinha um await
      
      if (worksheet == null) {
        throw Exception('Worksheet not found');
      }

      final rows = await worksheet.values.allRows();
      return rows;
    } catch (e) {
      throw Exception('Failed to fetch data from Google Sheets: $e');
    }
  }
}