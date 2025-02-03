import 'dart:developer';

import 'package:bios/app/model/social_link_model.dart';
import 'package:bios/app/pages/counter_controller.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinkButton extends StatelessWidget {
  final SocialLinkModel link;

  SocialLinkButton({super.key, required this.link});

  void _copyToClipboard(BuildContext context, String text) async {
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

  void _shareLink(String text) {
    Share.share(text);
  }

  final CounterController _controller = CounterController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 7,
          top: 6,
          child: CircleAvatar(
            radius: 23,
            backgroundColor: const Color.fromARGB(226, 255, 255, 255),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                link.icon,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 56,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => ElevatedButton(
              onPressed: () async {
                try {
                  final uri = Uri.parse(link.url);
                  link.countClick();

                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } catch (e) {
                  log('Error parsing URL:>>> $e');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('URL inválida ou vazia: ${link.url} ou vazia'),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 254, 254),
                backgroundColor: const Color.fromARGB(0, 95, 125, 139),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                textStyle: const TextStyle(
                  color: Color.fromARGB(209, 117, 18, 18),
                  fontSize: 16,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Text(link.title),
                  PopupMenuButton<String>(
                    tooltip: 'Menu',
                    onSelected: (value) {
                      if (value == 'copiar') {
                        _copyToClipboard(context, link.share);
                      } else if (value == 'compartilhar') {
                        _shareLink(link.share);
                        debugPrint("Compartilhar: ${link.share}");
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
