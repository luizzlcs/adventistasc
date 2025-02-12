import 'package:adventistasc/app/model/social_link_model.dart';
import 'package:adventistasc/app/pages/components/popup_menu_shared.dart';
import 'package:adventistasc/app/pages/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinkButton extends StatelessWidget {
  final SocialLinkModel link;

  SocialLinkButton({super.key, required this.link});
final _controller = GetIt.instance<CounterController>();
  // final CounterController _controller = CounterController();
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
                  PopupMenuShared(
                    messageLink: link.share,
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
