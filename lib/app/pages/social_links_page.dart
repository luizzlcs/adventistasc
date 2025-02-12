import 'dart:developer';

import 'package:adventistasc/app/model/social_link_model.dart';
import 'package:adventistasc/app/pages/components/church_avatar.dart';
import 'package:adventistasc/app/pages/components/gradient_card.dart';
import 'package:adventistasc/app/pages/components/social_link_button.dart';
import 'package:adventistasc/app/pages/components/statistic_of_the_page.dart';
import 'package:adventistasc/app/pages/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

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

  final _counterController = GetIt.instance<CounterController>();

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _counterController.initialize();
    _counterController.incrementPageAccess();
    log('contador: ${_counterController.pageAccessCount}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(186, 141, 171, 216),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GradientCard(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 45,
                      ),
                      ChurchAvatar(
                        image: widget.profileImageUrl,
                        userName: widget.username,
                      ),
                    ],
                  ),
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
                  StatisticOfThePage(controller: _counterController)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
