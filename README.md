# route_plus

Roteiro e documentação do projeto Flutter `route_plus`.

## Resumo

`route_plus` é um aplicativo Flutter que integra mapas (via `mapbox_maps_flutter`) e serviços de localização. Este repositório contém ajustes no build Android (Gradle/AGP/Kotlin) para manter compatibilidade com o plugin Mapbox e o Flutter.

## Estrutura relevante

- `lib/` — código Dart do aplicativo
- `lib/screens/map_screen.dart` — tela principal do mapa (documentada em `documentation/map_screen.md`)
- `android/` — código e configurações do build Android
- `documentation/` — documentações geradas para a tela e histórico de alterações

## Como rodar (dev)

1. Certifique-se de ter o Flutter instalado. Verifique com:

```bash
flutter --version
```

2. Configure a JDK (Android) se necessário. No Linux, instale OpenJDK 17 ou 21, por exemplo:

```bash
# exemplo (Debian/Ubuntu)
sudo apt update
sudo apt install openjdk-17-jdk
```

3. Adicione o token do Mapbox (se necessário) em `android/local.properties` (NÃO commitar):

```properties
# SDK_REGISTRY_TOKEN é usado por versões do Mapbox para baixar artefatos.
SDK_REGISTRY_TOKEN=seu_token_mapbox_aqui
```

4. Executar localmente:

```bash
flutter clean
flutter pub get
flutter run
```

## Alterações importantes aplicadas

Durante a manutenção do projeto foram aplicadas e testadas alterações no build Android para resolver incompatibilidades e manter o app compilando com `mapbox_maps_flutter`:

- `android/gradle/wrapper/gradle-wrapper.properties`
	- Versão usada: `gradle-8.14.2` (combinação validada como estável para este projeto)
- `android/settings.gradle.kts`
	- `com.android.application` = `8.11.1`
	- `org.jetbrains.kotlin.android` = `2.2.20`
- `android/build.gradle.kts`
	- `classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.2.20")`

Essas versões foram escolhidas porque mantêm compatibilidade com o `mapbox_maps_flutter` presente no `pubspec.yaml` e permitem que o build finalize com sucesso no ambiente atual.

## Avisos e compatibilidade

- O Flutter pode emitir avisos sobre versões que serão descontinuadas (Gradle, AGP, Kotlin). Esses avisos não impedem o build, mas indicam que, no futuro, é necessário atualizar o toolchain.
- Atualizar o Gradle/AGP/Kotlin para faixas mais novas (ex.: AGP 9 / Gradle 9.1 / Kotlin 2.3+) pode quebrar a compilação se dependências nativas (ex.: Mapbox) não oferecerem suporte. Proceda incrementalmente ao atualizar.

## Como atualizar `mapbox_maps_flutter` de forma segura

1. Rode `flutter pub outdated` para ver versões disponíveis:

```bash
flutter pub outdated
```

2. Identifique a versão mais recente do `mapbox_maps_flutter` compatível com sua versão do Flutter lendo o changelog no pub.dev.

3. Atualize `pubspec.yaml` apenas para a versão alvo e rode `flutter pub get`.

4. Teste o build Android. Se ocorrerem erros relacionados ao plugin Mapbox:
	 - Reveja mensagens no terminal; muitos erros emergem do módulo Android do plugin (dependências nativas, `SDK_REGISTRY_TOKEN`, ou APIs do AGP).
	 - Se necessário, atualize o KGP/AGP/Gradle **após** confirmar que a versão do plugin Mapbox suporta AGP 9+.

## Problemas conhecidos

- Erros relacionados a classes nativas (ex.: `ClassNotFoundException: com.mapbox.common.ResultCallbackNative`) podem indicar que as bibliotecas nativas não foram empacotadas ou há incompatibilidade ABI. Teste em outro dispositivo e confirme `minSdk` e `ndkVersion`.
- Ao tentar atualizar todas as versões ao mesmo tempo, o projeto pode quebrar. A sequência segura é: atualizar a dependência do plugin → atualizar Kotlin → atualizar AGP → atualizar Gradle.

## Logs e diagnóstico

Para logs detalhados do build Android:

```bash
cd android
./gradlew assembleDebug --stacktrace
```

Para ver dependências do pub:

```bash
flutter pub deps --style=compact
```

## Documentação adicional

- Tela mapa: `documentation/map_screen.md`
- Histórico de alterações e recomendações de upgrade: `documentation/project_changes.md`

## Próximos passos sugeridos

1. Se desejar, eu posso atualizar `mapbox_maps_flutter` para uma versão específica e testar o build (eu mesmo executarei os passos localmente).  
2. Gerar um branch com as mudanças de upgrade e testes para revisão.

---
_Última atualização: 5 de setembro de 2026_


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
