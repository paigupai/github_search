import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/routing/app_router.dart';
import 'package:github_search/utils/language_provider.dart';
import 'package:github_search/utils/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // router
    final goRouter = ref.watch(goRouterProvider);
    // 多言語
    final languageCode = ref.watch(languageLocaleProvider);
    // theme
    final themeMode = ref
        .watch(flexSchemeNotifierProvider.select((value) => value.themeMode));
    final lightTheme = ref
        .watch(flexSchemeNotifierProvider.select((value) => value.lightTheme));
    final darkTheme = ref
        .watch(flexSchemeNotifierProvider.select((value) => value.darkTheme));
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Flutter Demo',
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: Locale(languageCode.code),
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
