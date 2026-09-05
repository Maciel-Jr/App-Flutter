**Map Screen — Documentação**

- **Arquivo:** [lib/screens/map_screen.dart](lib/screens/map_screen.dart)
- **Objetivo:** Exibir mapa com localização do usuário e interações básicas (pan, zoom, marcadores). Usa Mapbox via plugin `mapbox_maps_flutter`.

**Visão Geral**
- A tela inicializa um widget de mapa, solicita permissões de localização (se necessário), e mostra o centro/zoom conforme a posição atual.
- Espera-se que o mapa suporte: toque para movimentar, gesto de pinça para zoom, e callbacks para eventos (ex.: clique em marcador).

**Widgets / Componentes principais**
- `MapboxMap` / widget do plugin: controla o mapa nativo.
- `FutureBuilder` / `StreamBuilder`: (se aplicável) para atualizar posição em tempo real.
- Controles UI: botões para centralizar, alternar camadas e solicitar permissão.

**Permissões Android / iOS**
- AndroidManifest.xml: adicionar as permissões de localização e internet se ainda não existirem.
  - `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`, `INTERNET`
- iOS: adicionar chaves em `Info.plist`: `NSLocationWhenInUseUsageDescription` (descrição do uso de localização).

**Configuração do Mapbox (necessária)**
- Token / credenciais: Algumas versões do Mapbox nativo esperam `SDK_REGISTRY_TOKEN` como propriedade de projeto ou variável de ambiente. Verifique o build do módulo Android do Mapbox: ele busca `SDK_REGISTRY_TOKEN` em `project.findProperty("SDK_REGISTRY_TOKEN")` ou `System.getenv("SDK_REGISTRY_TOKEN")`.
- Para desenvolvimento local, adicione em `android/local.properties` (NÃO commitar):

```properties
# Exemplo — NÃO versionar este arquivo
SDK_REGISTRY_TOKEN=seu_token_mapbox_aqui
```

- Alternativa: exportar `SDK_REGISTRY_TOKEN` no ambiente (shell) antes de builds CI.

**Notas de compatibilidade e problemas conhecidos**
- Mensagens de runtime vistas no log:
  - `ClassNotFoundException: com.mapbox.common.ResultCallbackNative` — indica que as bibliotecas nativas do Mapbox não foram encontradas/embaladas em alguns casos ou houve incompatibilidade ABI. Soluções:
    - Certifique-se de que `minSdk` e `targetSdk` estão compatíveis com a versão do Mapbox (geralmente minSdk >= 21).
    - Limpe build e reinstale: `flutter clean` → `flutter pub get` → `flutter run`.
    - Teste em outro dispositivo / emulador para verificar se o problema é específico do aparelho.
- Ao atualizar Gradle/AGP/Kotlin, a dependência `mapbox_maps_flutter` pode exigir versões específicas de AGP ou do plugin Kotlin; atualizar AGP sem atualizar a biblioteca pode quebrar o build.

**Como testar localmente**
1. Garanta token Mapbox em `android/local.properties` ou variável de ambiente.
2. Execute:

```bash
flutter clean
flutter pub get
flutter run
```

3. Teste permissões e funcionalidades de movimento/zoom/marcadores.

**Pontos de melhoria / TODOs**
- Adicionar tratamento de erro visível para falha ao carregar recursos nativos do Mapbox (mostrar mensagem ao usuário e logar detalhes).
- Adicionar fallback quando `SDK_REGISTRY_TOKEN` não estiver configurado (ex.: instruções na UI).

**Referências rápidas**
- Módulo: `mapbox_maps_flutter` — verificar documentação oficial e changelog do plugin.
- Logs de build: `./android/gradlew assembleDebug --stacktrace` para diagnóstico profundo.

