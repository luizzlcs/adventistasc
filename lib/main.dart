import 'package:adventistasc/app/config/setup.dart';
import 'package:adventistasc/app/core/constants/app_images.dart';
import 'package:adventistasc/app/core/constants/url_links.dart';
import 'package:adventistasc/app/model/social_link_model.dart';
import 'package:adventistasc/app/pages/counter_controller.dart';
import 'package:adventistasc/app/pages/social_links_page.dart';
import 'package:adventistasc/app/service/counter_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

final getIt = GetIt.instance;


void main() async {
  setup();
  Intl.defaultLocale = 'pt_BR';
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: "credentials.env"); // Carrega o arquivo .env
  String projectId = dotenv.env['PROJECT_ID'] ?? 'Projeto não encontrado';
  String privateKey =
      dotenv.env['PRIVATE_KEY'] ?? 'Chave privada não encontrada';

  debugPrint('Project ID: $projectId');
  debugPrint('Private Key: $privateKey');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _controller = GetIt.instance<CounterController>();

  @override
  Widget build(BuildContext context) {
    final List<SocialLinkModel> links = [
      SocialLinkModel(
        title: 'Tv Novo Tempo ao vivo 24h',
        url: UrlLinks.tvNovoTempo,
        icon: AppImages.tvNovoTempo,
        share: UrlLinks.tvNovoTempoMsg,
        count: _controller.counters[ButtonType.tv]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.tv),
      ),
      SocialLinkModel(
        title: 'YouTube',
        url: UrlLinks.youtube,
        icon: AppImages.youtube,
        share: UrlLinks.youtubeMsg,
        count: _controller.counters[ButtonType.youtube]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.youtube),
      ),
      SocialLinkModel(
        title: 'Peça gratuitamente',
        url: UrlLinks.cursoBiblico,
        icon: AppImages.cursoBiblico,
        share: UrlLinks.cursoBiblicoMsg,
        count: _controller.counters[ButtonType.peca]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.peca),
      ),
      SocialLinkModel(
        title: 'Nossa localização',
        url: UrlLinks.localizacao,
        icon: AppImages.map,
        share: UrlLinks.localizacaoMsg,
        count: _controller.counters[ButtonType.localizacao]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.localizacao),
      ),
      SocialLinkModel(
        title: 'Dizimar e ofertar',
        url: UrlLinks.doacao,
        icon: AppImages.sevenMe,
        share: UrlLinks.doacaoMsg,
        count: _controller.counters[ButtonType.dizimar]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.dizimar),
      ),
      SocialLinkModel(
        title: 'Estude a Bíblia com a gente',
        url: UrlLinks.estudoBiblico,
        icon: AppImages.estudoBiblico,
        share: UrlLinks.estudoBiblicoMsg,
        count: _controller.counters[ButtonType.estude]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.estude),
      ),
      SocialLinkModel(
        title: 'Facebook',
        url: UrlLinks.facebook,
        icon: AppImages.facebook,
        share: UrlLinks.facebookMsg,
        count: _controller.counters[ButtonType.facebook]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.facebook),
      ),
      SocialLinkModel(
        title: 'Instagram da Igreja',
        url: UrlLinks.instagram,
        icon: AppImages.instagram,
        share: UrlLinks.instagramMsg,
        count: _controller.counters[ButtonType.insta]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.insta),
      ),
      SocialLinkModel(
        title: 'Site Oficial',
        url: UrlLinks.siteAdventista,
        icon: AppImages.siteLogoAdv,
        share: UrlLinks.siteAdventistaMsg,
        count: _controller.counters[ButtonType.site]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.site),
      ),
      SocialLinkModel(
        title: 'Clube de Desbravadores',
        url: UrlLinks.clubeDesbravadores,
        icon: AppImages.logoDbv,
        share: UrlLinks.clubeDesbravadoresMsg,
        count: _controller.counters[ButtonType.desb]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.desb),
      ),
      SocialLinkModel(
        title: 'Clube de Aventureiros',
        url: UrlLinks.clubeAventureiros,
        icon: AppImages.logoAvt,
        share: UrlLinks.clubeAventureirosMsg,
        count: _controller.counters[ButtonType.avt]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.avt),
      ),
      SocialLinkModel(
        title: 'Banda Apóstolos',
        url: UrlLinks.bandaApostolos,
        icon: AppImages.logoApostolos,
        share: UrlLinks.bandaApostolosMsg,
        count: _controller.counters[ButtonType.banda]?['count']?.toString() ?? '0',
        countClick: () => _controller.incrementCounter(ButtonType.banda),
      ),
    ];

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Define os locales suportados
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      // Define o locale inicial
      locale: const Locale('pt', 'BR'),
      debugShowCheckedModeBanner: false,
      home: SocialLinksPage(
        profileImageUrl: AppImages.siteLogoAdv,
        username: 'adventistaSC',
        links: links,
      ),
    );
  }
}
