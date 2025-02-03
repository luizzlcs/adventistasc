import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class PopupMenuShared extends StatelessWidget {
  const PopupMenuShared({
    super.key,
    required this.messageLink,
  });

  final String messageLink;

  void copyToClipboard(BuildContext context, String text) async {
    await FlutterClipboard.copy(text);
    if (context.mounted) {
      // Boa prática adicionar esta verificação
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link copiado para a área de transferência!'),
        ),
      );
    }
  }

  void shareLink(String text) {
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Menu',
      onSelected: (value) {
        if (value == 'copiar') {
          copyToClipboard(context, messageLink);
        } else if (value == 'compartilhar') {
          shareLink(messageLink);
        } else {
          debugPrint("Outra opção selecionada.");
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'copiar',
          child: Text('Copiar link'),
        ),
        const PopupMenuItem(
          value: 'compartilhar',
          child: Text('Compartilhar'),
        ),
      ],
    );
  }
}
