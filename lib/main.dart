import 'package:adventistasc/app/config/setup.dart';
import 'package:adventistasc/app/core/constants/app_images.dart';
import 'package:adventistasc/app/core/constants/parameters_social_link.dart';
import 'package:adventistasc/app/pages/social_links_page.dart';
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    

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
        links: ParametersScocialLink.links,
      ),
    );
  }
}
