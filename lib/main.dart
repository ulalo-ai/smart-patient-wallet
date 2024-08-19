import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:ulalo/view/auth_ui.dart';
import 'package:ulalo/view/starter_ui.dart';
import 'core/global.dart';
import 'core/theme.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PolygonIdSdk.init(
    env: EnvEntity(
      pushUrl: 'https://push-staging.polygonid.com/api/v1',
      ipfsUrl: "https://286CD40A3784FA76A8F2:0duhrPoWYCJ7m7yetyfcCoLNfHRxFPLPC0L5MekN@api.filebase.io/v1/ipfs:5001",
      chainConfigs: {
        "80002": ChainConfigEntity(
          blockchain: 'polygon',
          network: 'amoy',
          rpcUrl: 'https://rpc-amoy.polygon.technology/',
          stateContractAddr: '0x1a4cC30f2aA0377b0c3bc9848766D90cb4404124',
        )
      },
      didMethods: [],
    ),
  );
  runApp(const MyApp());
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
