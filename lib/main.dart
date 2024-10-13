import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:provider/provider.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulalo/service/wallet.provider.dart';
import 'package:ulalo/view/auth_ui.dart';
import 'package:ulalo/view/starter_ui.dart';
import 'package:ulalo/view/ui_home.dart';
import 'core/creds.dart';
import 'core/global.dart';
import 'core/theme.dart';
import 'generated/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletConnectProvider()),
      ],
      child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('fr')],
          path: 'assets/translations', // <-- change the path of the translation files
          fallbackLocale: const Locale('en'),
          assetLoader: const CodegenLoader(),
          child: const MyApp()
      )
    ),
  );
}

class StoreBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    // Get.lazyPut(() => PhoneInputController());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ReownAppKitModalThemeData get _customTheme => ReownAppKitModalThemeData(
    lightColors: ReownAppKitModalColors.lightMode.copyWith(
      accent100: const Color.fromARGB(255, 30, 59, 236),
      background100: const Color.fromARGB(255, 161, 183, 231),
      // Main Modal's background color
      background125: const Color.fromARGB(255, 206, 221, 255),
      background175: const Color.fromARGB(255, 237, 241, 255),
      inverse100: const Color.fromARGB(255, 233, 237, 236),
      inverse000: const Color.fromARGB(255, 22, 18, 19),
      // Main Modal's text
      foreground100: const Color.fromARGB(255, 22, 18, 19),
      // Secondary Modal's text
      foreground150: const Color.fromARGB(255, 22, 18, 19),
    ),
    darkColors: ReownAppKitModalColors.darkMode.copyWith(
      accent100: const Color.fromARGB(255, 161, 183, 231),
      background100: const Color.fromARGB(255, 30, 59, 236),
      // Main Modal's background color
      background125: const Color.fromARGB(255, 12, 23, 99),
      background175: const Color.fromARGB(255, 78, 103, 230),
      inverse100: const Color.fromARGB(255, 22, 18, 19),
      inverse000: const Color.fromARGB(255, 233, 237, 236),
      // Main Modal's text
      foreground100: const Color.fromARGB(255, 233, 237, 236),
      // Secondary Modal's text
      foreground150: const Color.fromARGB(255, 233, 237, 236),
    ),
    radiuses: ReownAppKitModalRadiuses.square,
  );

  Future<List<Object>> _initDeps() async {
    final deps = await Future.wait([
      SharedPreferences.getInstance(),
      ReownCoreUtils.getPackageName(),
    ]);
    return deps;
  }

  @override
  Widget build(BuildContext context) {

    Sizes.init(context);
    return ReownAppKitModalTheme(
      isDarkMode: false,
      themeData: _customTheme,
      child: GetMaterialApp(
          title: 'Ulalo Med DApp',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: UlaloTheme,
          themeMode: ThemeMode.system,
          initialBinding: StoreBinding(),
          initialRoute: "/",
          getPages: [
            GetPage(name: '/', page: () {
              return const StarterUi();
            }),
            GetPage(name: '/auth', page: () => const AuthUi()),
            GetPage(name: '/home', page: () {
              return FutureBuilder<List<Object>>(
                future: _initDeps(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return HomePage(
                      prefs: snapshot.data!.first as SharedPreferences,
                      bundleId: snapshot.data!.last as String,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }),
          ]
      ),
    );
  }
}
