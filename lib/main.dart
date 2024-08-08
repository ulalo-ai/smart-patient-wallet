import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:ulalo/view/auth_ui.dart';
import 'package:ulalo/view/starter_ui.dart';

import 'core/global.dart';
import 'core/theme.dart';
import 'generated/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('fr')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const MyApp()
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Sizes.init(context);
    return GetMaterialApp(
        title: 'Motion Ride',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: UlaloTheme,
        themeMode: ThemeMode.system,
        initialBinding: StoreBinding(),
        // home: StarterUi(),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () {
            return const StarterUi();
          }),
          GetPage(name: '/auth', page: () => const AuthUi()),
        ]
    );
  }
}
