import 'dart:developer';

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
import 'package:ulalo/view/ui_data.dart';
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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<Widget>? tabViews;

  List<TabItem>? tabItems;

  var _appKitModal;

  late bool isConnected;

  @override
  void dispose() {
    // Remove the lifecycle observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    _appKitModal = web3Credentials(context);
    Future.microtask(() async {
      await _appKitModal.init();
    });
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    setState(() {
      isConnected = _appKitModal.isConnected;
    });

    _appKitModal.onModalDisconnect.subscribe((ModalDisconnect? event) {
      log("On Disconnect: $event");
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/', // The new route to push
            (Route<dynamic> route) => false, // Remove all previous routes
      );
    });
  }

  // This method is called when the app gains or loses focus
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(_appKitModal.isConnected == false){
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/', // The new route to push
            (Route<dynamic> route) => false, // Remove all previous routes
      );
    }
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
            // leading: Padding(padding: const EdgeInsets.only(left:8), child: IconButton(onPressed: (){}, icon: const Icon(FluentIcons.line_horizontal_3_20_filled, size: 32))),
            automaticallyImplyLeading: false,
            leadingWidth: 0,
            centerTitle: true,
            title: AppKitModalAccountButton(
              appKitModal: _appKitModal, size: BaseButtonSize.small
            ),
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
                UiDocIa(appKitModal: _appKitModal),
                UiData(appKitModal: _appKitModal),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomBarDivider(
          items: const [
            TabItem(
                icon: IconData(59995,
                    fontFamily: 'FluentSystemIcons-Regular',
                    fontPackage: 'fluentui_system_icons'),
                title: 'Analyze'),
            TabItem(
                icon: IconData(61656,
                    fontFamily: 'FluentSystemIcons-Regular',
                    fontPackage: 'fluentui_system_icons'),
                title: 'My Data'),
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
          onTap: (int index) => appProvider.changeTab(index, _appKitModal),
        ),
      );
    });
  }
}
