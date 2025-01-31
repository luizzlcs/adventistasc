import 'dart:developer';

import 'package:bios/app/model/social_link_model.dart';
import 'package:bios/app/pages/components/social_link_button.dart';
import 'package:bios/app/pages/counter_controller.dart';
import 'package:flutter/material.dart';

class SocialLinksPage extends StatefulWidget {
  final String profileImageUrl;
  final String username;
  final List<SocialLinkModel> links;

  const SocialLinksPage(
      {super.key,
      required this.profileImageUrl,
      required this.username,
      required this.links});

  @override
  State<SocialLinksPage> createState() => _SocialLinksPageState();
}

class _SocialLinksPageState extends State<SocialLinksPage> {
  final CounterController _counterController = CounterController();

  @override
  void initState() {
    super.initState();
    // _counterController.updateSheet();
    _counterController.initializeAndIncrement();
    log('contador: ${_counterController.pageAccessCount}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(186, 141, 171, 216),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 480,
              minWidth: 250,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 2, 38, 68),
                  Color.fromARGB(255, 151, 189, 238),
                  Color.fromARGB(255, 151, 189, 238),
                  Color.fromARGB(255, 151, 189, 238),
                  Color.fromARGB(255, 75, 158, 226),
                  Color.fromARGB(255, 2, 38, 68),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Profile Image
                  CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(widget.profileImageUrl),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Username
                  Text(
                    '@${widget.username}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Links ListView

                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: widget.links.length,
                      itemBuilder: (context, index) {
                        final link = widget.links[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SocialLinkButton(link: link),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    color: Colors.white54,
                  ),
                  const Text(
                    'Igreja Adventista do 7º Dia - Conj. Sat. Catarina, Natal - RN',
                    style: TextStyle(
                      color: Color.fromARGB(255, 189, 188, 188),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: AnimatedBuilder(
                      animation: _counterController,
                      builder: (context, child) => Text(
                        'Númro de acessos: ${_counterController.pageAccessCount}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 122, 122, 122)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
