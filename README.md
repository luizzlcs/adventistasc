# Aplicativo de Diretório de Links em Flutter

<a href="()"></a>
[ACESSAR  PROJETO](https://github.com/luizzlcs/order/blob/master/src/main/java/com/antares/order/OrderApplication.java)

<p align="center">
 <img src="assets/images/app.png" width="170" height="250" />
</p>

## 🌐 Acesso ao Projeto
O projeto está disponível em: https://adventistasc.netlify.app

## 📝 Descrição

Um aplicativo web desenvolvido em Flutter para fornecer um diretório centralizado de links para uma instituição. O aplicativo possui funcionalidade de compartilhamento de links personalizado com mensagens customizadas e inclui um sistema abrangente de análise que rastreia visitas à página e cliques nos botões.

## 🚀 Funcionalidades

- Roteamento direto para páginas institucionais
- Menu de compartilhamento personalizado com opções de copiar e compartilhar
- Sistema de mensagens personalizadas para cada link
- Rastreamento de análises de acesso (visualizações de página e cliques em botões)
- Integração com Google Sheets para armazenamento de dados
- Gerenciamento de variáveis de ambiente para armazenamento seguro de credenciais

## 🛠️ Tecnologias Utilizadas

- Flutter/Dart
- Serviços Google Cloud
- API do Google Sheets
- Netlify (hospedagem)

## 📁 Estrutura do Projeto

```
lib/
├── app/
│   ├── config/
│   │   └── setup.dart
│   ├── core/
│   │   └── constants/
│   │       ├── app_images.dart
│   │       └── url_links.dart
│   ├── model/
│   │   └── social_link_model.dart
│   ├── pages/
│   │   └── components/
│   │       ├── counter_controller.dart
│   │       └── social_links_page.dart
│   ├── repositories/
│   ├── service/
│   │   └── counter_service.dart
│   └── main.dart
```

## 📋 Dependências

```yaml
dependencies:
  flutter: sdk: flutter
  cupertino_icons: ^1.0.6
  url_launcher: ^6.3.1
  clipboard: ^0.1.3
  share_plus: ^10.1.4
  googleapis: ^11.0.0
  googleapis_auth: ^1.4.0
  shared_preferences: ^2.1.0
  favicon: ^1.1.2
  flutter_native_splash: ^2.4.1
  flutter_dotenv: ^5.2.1
  flutter_localizations: sdk: flutter
  intl: ^0.20.2
  get_it: ^8.0.3
```

## 🔧 Dependências de Desenvolvimento

```yaml
dev_dependencies:
  flutter_test: sdk: flutter
  flutter_lints: ^3.0.0
```

## 🎨 Configuração da Tela de Splash

```yaml
flutter_native_splash:
  color: "#D9D9D9"
  image: "assets/images/splash.png"
  android_12:
    image: assets/images/splash.png
    color: "#D9D9D9"
    android: true
    ios: true
    web: true
```

## 🌐 Configuração do Ambiente

1. Configurar os Serviços do Google Cloud e obter credenciais da API
2. Configurar o Google Sheets para armazenamento de dados
3. Configurar variáveis de ambiente no Netlify para as credenciais do Google Sheets
4. Garantir que todos os recursos necessários estejam presentes no diretório `assets/images/`
5. Incluir arquivo `credentials.env` (não rastreado no git)

## 💻 Requisitos de Desenvolvimento

- SDK do Dart: '>=3.4.4 <4.0.0'
- Flutter (última versão estável)

## 📄 Versão

Versão atual: 1.0.0+1

## 📝 Observação

Este projeto não é publicado no pub.dev e destina-se apenas para uso privado.

### Autor
Sou desenvolvedor fullstack, sempre buscando entregar soluções completas e eficientes, utilizando tecnologias modernas como Dart e Flutter no front-end e Java no back-end. Desde 2022, trabalho na Ponto Care, criando aplicativos para Android e Web, com foco em inovação, qualidade e garantindo a melhor experiência para o usuário.

<img alt="Luiz Carlos" title="Luiz Carlos" src="https://avatars.githubusercontent.com/u/29442285?s=96&v=4" height="100" width="100" />

[![LinkedIn Badge](https://img.shields.io/badge/-LUIZ_CARLOS-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/luizzlcs/)](https://www.linkedin.com/in/luizzlcs/)
