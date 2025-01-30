import 'package:bios/app/core/constants/app_images.dart';
import 'package:bios/app/core/constants/url_links.dart';
import 'package:bios/app/model/social_link_model.dart';
import 'package:bios/app/pages/social_links_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SocialLinkModel> links = [
      const SocialLinkModel(
        title: 'Retiro Espiritual - Faça sua inscrição',
        url: UrlLinks.retiroEspiritual,
        icon: AppImages.acampamento,
        share: UrlLinks.retiroEspiritualMsg,
      ),const SocialLinkModel(
        title: 'Tv Novo Tempo ao vivo 24h',
        url: UrlLinks.tvNovoTempo,
        icon: AppImages.tvNovoTempo,
        share: UrlLinks.tvNovoTempoMsg,
      ),
      const SocialLinkModel(
        title: 'YouTube',
        url: UrlLinks.youtube,
        icon: AppImages.youtube,
        share: UrlLinks.youtubeMsg,
      ),
      const SocialLinkModel(
        title: 'Peça gratuitamente',
        url: UrlLinks.cursoBiblico,
        icon: AppImages.cursoBiblico,
        share: UrlLinks.cursoBiblicoMsg,
      ),
      const SocialLinkModel(
        title: 'Nossa localização',
        url: UrlLinks.localizacao,
        icon: AppImages.map,
        share: UrlLinks.localizacaoMsg,
      ),
      const SocialLinkModel(
        title: 'Dizimar e ofertar',
        url: UrlLinks.doacao,
        icon: AppImages.sevenMe,
        share: UrlLinks.doacaoMsg,
      ),
      const SocialLinkModel(
        title: 'Estude a Bíblia com a gente',
        url: UrlLinks.estudoBiblico,
        icon: AppImages.estudoBiblico,
        share: UrlLinks.estudoBiblicoMsg,
      ),
      const SocialLinkModel(
        title: 'Facebook',
        url: UrlLinks.facebook,
        icon: AppImages.facebook,
        share: UrlLinks.facebookMsg,
      ),
      const SocialLinkModel(
        title: 'Instagram da Igreja',
        url: UrlLinks.instagram,
        icon: AppImages.instagram,
        share: UrlLinks.instagramMsg,
      ),
      const SocialLinkModel(
        title: 'Site Oficial dos Adventistas do 7º Dia',
        url: UrlLinks.siteAdventista,
        icon: AppImages.siteLogoAdv,
        share: UrlLinks.siteAdventistaMsg,
      ),
      const SocialLinkModel(
        title: 'Clube de Desbravadores',
        url: UrlLinks.clubeDesbravadores,
        icon: AppImages.logoDbv,
        share: UrlLinks.clubeDesbravadoresMsg,
      ),
      const SocialLinkModel(
        title: 'Clube de Aventureiros',
        url: UrlLinks.clubeAventureiros,
        icon: AppImages.logoAvt,
        share: UrlLinks.clubeAventureirosMsg,
      ),
      const SocialLinkModel(
        title: 'Banda Apóstolos',
        url: UrlLinks.bandaApostolos,
        icon: AppImages.logoApostolos,
        share: UrlLinks.bandaApostolosMsg,
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SocialLinksPage(
        profileImageUrl: AppImages.siteLogoAdv,
        username: 'adventistaSC',
        links: links,
      ),
    );
  }
}
