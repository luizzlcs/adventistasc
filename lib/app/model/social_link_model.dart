
import 'package:flutter/material.dart';

class SocialLinkModel {
  final String title;
  final String url;
  final String icon;
  final String share;
  final String count;
  final VoidCallback countClick;

  const SocialLinkModel({
    required this.title,
    required this.url,
    required this.icon,
    required this.share,
    required this.count,
    required this.countClick,
  });
}