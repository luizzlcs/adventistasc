import 'package:adventistasc/app/core/constants/url_links.dart';
import 'package:adventistasc/app/pages/components/popup_menu_shared.dart';
import 'package:flutter/material.dart';

class ChurchAvatar extends StatelessWidget {
  const ChurchAvatar({
    super.key,
    required this.image,
    required this.userName,
  });

  final String image;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          //Imagem logo da igreja
          const SizedBox(
             width:36,
          ),
          CircleAvatar(
            radius: 44,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(image),
            ),
          ),
          const SizedBox(width: 10),
          const Material(
            color: Colors.transparent,
            //Popup menu
            child: PopupMenuShared(
              messageLink: UrlLinks.nossaIgrejaMsg,
            ),
          ),
        ]),

        const SizedBox(height: 10),
        // Usuário do instagram
        Text(
          '@$userName',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
