import 'package:bios/app/model/social_link_model.dart';
import 'package:bios/app/pages/components/social_link_button.dart';
import 'package:flutter/material.dart';

class SocialLinksPage extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final List<SocialLinkModel> links;

  const SocialLinksPage(
      {super.key,
      required this.profileImageUrl,
      required this.username,
      required this.links});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.yellowAccent],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Image
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              const SizedBox(height: 10),
              // Username
              Text(
                '@$username',
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
                  itemCount: links.length,
                  itemBuilder: (context, index) {
                    final link = links[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SocialLinkButton(link: link),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
