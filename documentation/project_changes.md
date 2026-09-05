**Documentação do Projeto — Alterações e Histórico desde a criação**

- **Local do projeto:** raiz do repositório
- **Arquivos centrais alterados (resumo):**
  - `android/gradle/wrapper/gradle-wrapper.properties`
  - `android/settings.gradle.kts`
  - `android/build.gradle.kts`
  - (possível alteração proposta) `pubspec.yaml` — atualizar `mapbox_maps_flutter` com cautela

**Motivo das alterações realizadas**
- Corrigir falha de build inicial causada por incompatibilidade mínima do Flutter com a versão do Gradle.
- Garantir que o projeto compile com a dependência `mapbox_maps_flutter` instalada.

**Alterações aplicadas (detalhe técnico)**
- `android/gradle/wrapper/gradle-wrapper.properties`
  - Antes: `distributionUrl=https\://services.gradle.org/distributions/gradle-8.13-bin.zip`
  - Temporariamente atualizei para `8.14.2` (versão estável compatível) e depois mantive `8.14.2` como combinação segura.
- `android/settings.gradle.kts`
  - Ajustei a versão do plugin Android (`com.android.application`) e do plugin Kotlin conforme necessário em tentativas de atualização;
  - Versão funcional final usada: `com.android.application` = `8.11.1`, `org.jetbrains.kotlin.android` = `2.2.20` (combinação que manteve o projeto compilando com Mapbox no contexto atual).
- `android/build.gradle.kts`
  - Ajustei a entrada de classpath do `kotlin-gradle-plugin` para combinar com a versão do plugin Kotlin declarada em `settings.gradle.kts`.

**Por que não atualizamos para AGP 9/Gradle 9.1+ imediatamente**
- Ao tentar atualizar para AGP 9 e Gradle 9.1 foi detectado conflito com `mapbox_maps_flutter` (erro em tempo de build relacionado a `kotlin()` no subprojeto do Mapbox), ou com versões binárias das libs nativas.
- Solução segura exige atualizar `mapbox_maps_flutter` para uma versão que suporte AGP 9 e alinhar Kotlin/Gradle nas dependências transientes.

**Recomendações para atualização segura (sequência sugerida)**
1. Verificar versão atual do Flutter: `flutter --version`.
2. Rodar auditoria de dependências:

```bash
flutter pub outdated
```

3. Verificar qual versão do `mapbox_maps_flutter` torna-se compatível com AGP 9+ lendo o changelog do plugin no pub.dev ou no repositório upstream.
4. Fazer mudanças incrementais (não todas de uma vez):
  - Atualizar `mapbox_maps_flutter` para a versão mais recente compatível testando build.
  - Atualizar `org.jetbrains.kotlin.android` em `android/settings.gradle.kts` para a versão mínima exigida pelo plugin Mapbox/Flutter combinado.
  - Atualizar `kotlin-gradle-plugin` no `android/build.gradle.kts` para corresponder.
  - Atualizar `android/gradle/wrapper/gradle-wrapper.properties` para `distributionUrl=https\://services.gradle.org/distributions/gradle-9.1.0-bin.zip`.
  - Atualizar AGP em `android/settings.gradle.kts` para `9.0.1`.
  - Rodar `flutter clean` e `flutter run` a cada passo e corrigir erros que surgirem.

5. Se o build quebrar por causa de plugins binários (ex.: Mapbox), rever o changelog do plugin e abrir issue no repositório do plugin ou buscar versão alternativa.

**Comandos úteis**

```bash
# Auditoria e atualização de dependências Dart
flutter pub outdated
flutter pub upgrade --major-versions   # use com cuidado

# Limpar e reconstruir
flutter clean
flutter pub get
flutter run

# Build Android com informações de stacktrace
cd android && ./gradlew assembleDebug --stacktrace
```

**Observações finais / riscos**
- Atualizações de AGP/Gradle/Kotlin podem exigir ajustes na sintaxe Kotlin/Gradle dos scripts do build (ex.: diferenças entre Groovy e Kotlin DSLs), e plugins mais antigos podem não suportar as novas APIs.
- Sempre mantenha `android/local.properties` fora do versionamento com tokens/credenciais sensíveis.
- Ao atualizar o `mapbox_maps_flutter`, verifique requisitos nativos (tokens, downloads maven privados, variáveis `SDK_REGISTRY_TOKEN`).

**Próximos passos que posso executar para você**
- Atualizar `pubspec.yaml` para uma versão específica do `mapbox_maps_flutter` e testar build incremental.
- Tentar atualizar para AGP 9 / Gradle 9.1 após garantir que `mapbox_maps_flutter` suporta essa combinação.
- Gerar um branch de upgrade com mudanças e testes automáticos locais.

