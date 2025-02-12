import 'dart:developer';
import 'package:adventistasc/app/repositories/counter_repository.dart';
import 'package:intl/intl.dart';

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

class CounterService {
  final CounterRepository repository;

  CounterService(this.repository);

  final Map<ButtonType, int> _rowMapping = {
    ButtonType.retiro: 3,
    ButtonType.tv: 5,
    ButtonType.youtube: 7,
    ButtonType.peca: 9,
    ButtonType.localizacao: 11,
    ButtonType.dizimar: 13,
    ButtonType.estude: 15,
    ButtonType.facebook: 17,
    ButtonType.insta: 19,
    ButtonType.site: 21,
    ButtonType.desb: 23,
    ButtonType.avt: 25,
    ButtonType.banda: 27
  };

  Future<Map<ButtonType, Map<String, dynamic>>> fetchAllCounters() async {
    Map<ButtonType, Map<String, dynamic>> counters = {};
    for (var type in ButtonType.values) {
      final row = _rowMapping[type]!;
      final data = await repository.getValues('B$row:B${row + 1}');
      if (data != null && data.isNotEmpty) {
        counters[type] = {
          "date": DateTime.parse(data[0][0]),
          "count": int.parse(data[1][0])
        };
      }
    }
    return counters;
  }

  Future<void> incrementCounter(ButtonType type) async {
    
    final row = _rowMapping[type]!;
    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    final data = await repository.getValues('B${row + 1}');
    int currentCount = 0;
    if (data != null && data.isNotEmpty) {
      currentCount = int.tryParse(data[0][0]) ?? 0;
    }

    await repository.updateValues('B$row:B${row + 1}', [
      [now],
      [currentCount + 1]
    ]);
    log('Contador atualizado para $type: ${currentCount + 1}');
  }

  Future<Map<String, dynamic>> fetchPageAccess() async {
    final data = await repository.getValues('B1:B2');
    if (data != null && data.isNotEmpty) {
      return {
        "date": DateTime.parse(data[0][0]),
        "count": int.parse(data[1][0])
      };
    }
    return {"date": DateTime.now(), "count": 0};
  }

  Future<void> incrementPageAccess() async {
    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final data = await repository.getValues('B2');
    int currentCount =
        (data != null && data.isNotEmpty) ? int.parse(data[0][0]) : 0;

    await repository.updateValues('B1:B2', [
      [now],
      [currentCount + 1]
    ]);
    log('Acesso à página atualizado: ${currentCount + 1}');
  }
}
