import 'package:cryptofont/cryptofont.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulalo/core/global.dart';
import 'package:ulalo/core/iconly_curved_icons.dart';
import 'package:ulalo/core/theme.dart';
import 'package:ulalo/view/ui_doc_ia.dart';
import 'package:reown_appkit/reown_appkit.dart';

import '../core/creds.dart';
import '../service/wallet.provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.prefs, required this.bundleId});

  final SharedPreferences prefs;
  final String bundleId;

  @override
  _HomePageState createState() => _HomePageState();
}

const _storage = FlutterSecureStorage();

class _HomePageState extends State<HomePage> {
  List<Widget>? tabViews;

  List<TabItem>? tabItems;

  late ReownAppKitModal _appKitModal;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<WalletConnectProvider>(context);

    return Consumer<WalletConnectProvider>(
        builder: (context, userProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(padding: const EdgeInsets.only(left:8), child: IconButton(onPressed: (){}, icon: const Icon(FluentIcons.line_horizontal_3_20_filled, size: 32))),
            automaticallyImplyLeading: false,
            leadingWidth: 0,
            centerTitle: true,
            // title: W3MAccountButton(service: w3mService),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(FluentIcons.alert_48_regular, size: 32)),
              horizontalSpace(8)
            ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: UlaloColors.primary)
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Color(0xFFF0F0F0),
              ),
            ),
            IndexedStack(
              index: appProvider.activeTab,
              children: [
                const UiDocIa(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomBarDivider(
          items: const [
            TabItem(
                icon: IconData(63547,
                    fontFamily: 'FluentSystemIcons-Regular',
                    fontPackage: 'fluentui_system_icons'),
                title: 'Doc IA'),
            TabItem(
                icon: IconData(61731,
                    fontFamily: 'FluentSystemIcons-Regular',
                    fontPackage: 'fluentui_system_icons'),
                title: 'IPFS'),
            TabItem(
                icon: IconData(0xea96,
                    fontFamily: 'cryptofont',
                    fontPackage: 'cryptofont'),
                title: 'ERC'),
            TabItem(
                icon: IconData(0xf411,
                    fontFamily: 'CupertinoIcons',
                    fontPackage: 'cupertino_icons'),
                title: 'Settings'),
          ],
          iconSize: 28,
          boxShadow: const [
            BoxShadow(
              color: UlaloColors.textGrey600,
              offset: Offset(0, -.08),
            ),
          ],
          backgroundColor: Colors.black,
          color: Colors.white,
          colorSelected: UlaloColors.primary,
          styleDivider: StyleDivider.top,
          countStyle: const CountStyle(
            background: Colors.white,
            color: UlaloColors.primary,
          ),
          titleStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 8,
          ),
          indexSelected: appProvider.activeTab,
          onTap: (int index) => appProvider.changeTab(index),
        ),
      );
    });
  }
}
