import 'package:adventistasc/app/model/social_link_model.dart';
import 'package:adventistasc/app/pages/counter_controller.dart';
import 'package:adventistasc/app/service/counter_service.dart';
import 'package:flutter/material.dart';

import '../repositories/google_sheets_repository.dart';

class SocialLinksService {
  final GoogleSheetsRepository _repository;
  final CounterController _controller;

  SocialLinksService(this._repository, this._controller);

  Future<List<SocialLinkModel>> getSocialLinks() async {
    final rows = await _repository.fetchSheetData();
    final links = <SocialLinkModel>[];
    
    // Processar dados com espaçamento entre os itens (6 linhas por item: 5 para dados + 1 vazia)
    for (var i = 0; i < rows.length; i += 6) {
      // Verifique se temos linhas suficientes para um item completo.
      if (i + 4 >= rows.length) break;
      
      // Verifique se a primeira célula do grupo atual está vazia (fim dos dados).
      if (rows[i][1].trim().isEmpty) break;

      try {
        final buttonType = ButtonType.values.firstWhere(
          (type) => type.toString() == 'ButtonType.${rows[i + 4][1]}',
          orElse: () => ButtonType.tv,
        );

        links.add(
          SocialLinkModel(
            title: rows[i][1],      // Title in row 1, column B
            url: rows[i + 1][1],    // URL in row 2, column B
            icon: rows[i + 2][1],   // Icon in row 3, column B
            share: rows[i + 3][1],  // Share message in row 4, column B
            count: _controller.counters[buttonType]?['count']?.toString() ?? '0',
            countClick: () => _controller.incrementCounter(buttonType),
          ),
        );
      } catch (e) {
        debugPrint('Error processing row $i: $e');
        // Pule este item se houver um erro e continue com o próximo.
        continue;
      }
    }
    
    return links;
  }
}