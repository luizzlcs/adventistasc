import 'package:bios/app/core/constants/app_images.dart';
import 'package:bios/app/core/constants/url_links.dart';
import 'package:bios/app/model/social_link_model.dart';
import 'package:bios/app/pages/counter_controller.dart';
import 'package:bios/app/pages/social_links_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CounterController _controller = CounterController();

  @override
  Widget build(BuildContext context) {
    final List<SocialLinkModel> links = [
      SocialLinkModel(
        title: 'Tv Novo Tempo ao vivo 24h',
        url: UrlLinks.tvNovoTempo,
        icon: AppImages.tvNovoTempo,
        share: UrlLinks.tvNovoTempoMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.tv),
      ),
      SocialLinkModel(
        title: 'YouTube',
        url: UrlLinks.youtube,
        icon: AppImages.youtube,
        share: UrlLinks.youtubeMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.youtube),
      ),
      SocialLinkModel(
        title: 'Peça gratuitamente',
        url: UrlLinks.cursoBiblico,
        icon: AppImages.cursoBiblico,
        share: UrlLinks.cursoBiblicoMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.peca),
      ),
      SocialLinkModel(
        title: 'Nossa localização',
        url: UrlLinks.localizacao,
        icon: AppImages.map,
        share: UrlLinks.localizacaoMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.localizacao),
      ),
      SocialLinkModel(
        title: 'Dizimar e ofertar',
        url: UrlLinks.doacao,
        icon: AppImages.sevenMe,
        share: UrlLinks.doacaoMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.dizimar),
      ),
      SocialLinkModel(
        title: 'Estude a Bíblia com a gente',
        url: UrlLinks.estudoBiblico,
        icon: AppImages.estudoBiblico,
        share: UrlLinks.estudoBiblicoMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.estude),
      ),
      SocialLinkModel(
        title: 'Facebook',
        url: UrlLinks.facebook,
        icon: AppImages.facebook,
        share: UrlLinks.facebookMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.facebook),
      ),
      SocialLinkModel(
        title: 'Instagram da Igreja',
        url: UrlLinks.instagram,
        icon: AppImages.instagram,
        share: UrlLinks.instagramMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.insta),
      ),
      SocialLinkModel(
        title: 'Site Oficial',
        url: UrlLinks.siteAdventista,
        icon: AppImages.siteLogoAdv,
        share: UrlLinks.siteAdventistaMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.site),
      ),
      SocialLinkModel(
        title: 'Clube de Desbravadores',
        url: UrlLinks.clubeDesbravadores,
        icon: AppImages.logoDbv,
        share: UrlLinks.clubeDesbravadoresMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.desb),
      ),
      SocialLinkModel(
        title: 'Clube de Aventureiros',
        url: UrlLinks.clubeAventureiros,
        icon: AppImages.logoAvt,
        share: UrlLinks.clubeAventureirosMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.avt),
      ),
      SocialLinkModel(
        title: 'Banda Apóstolos',
        url: UrlLinks.bandaApostolos,
        icon: AppImages.logoApostolos,
        share: UrlLinks.bandaApostolosMsg,
        count: _controller.getCount(ButtonType.retiro).toString(),
        countClick: () => _controller.incrementCounter(ButtonType.banda),
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
