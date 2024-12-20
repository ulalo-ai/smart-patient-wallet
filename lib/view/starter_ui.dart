import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:ulalo/core/global.dart';
import 'package:ulalo/core/theme.dart';
import 'package:ulalo/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core/creds.dart';

class StarterUi extends StatefulWidget {
  const StarterUi({Key? key}) : super(key: key);

  @override
  _StarterUiState createState() => _StarterUiState();
}

class _StarterUiState extends State<StarterUi> with WidgetsBindingObserver {

  var _appKitModal;
  bool isConnected = false;

  @override
  void initState() {
    _appKitModal = web3Credentials(context);
    Future.microtask(() async {
      await _appKitModal.init();
    });

    super.initState();
    // Register this widget as a lifecycle observer
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        isConnected = _appKitModal.isConnected;
      });
    });

    _appKitModal.onModalConnect.subscribe((ModalConnect? event) {
      setState(() {
        isConnected = _appKitModal.isConnected;
      });
      log("On Connect: $event");
    });

    _appKitModal.onModalUpdate.subscribe((ModalConnect? event) {
      setState(() {
        isConnected = _appKitModal.isConnected;
      });
      log("On Update: $event");
    });

    _appKitModal.onModalNetworkChange.subscribe((ModalNetworkChange? event) {
      setState(() {
        isConnected = _appKitModal.isConnected;
      });
      log("On Network Change: $event");
    });

    _appKitModal.onModalDisconnect.subscribe((ModalDisconnect? event) {
      setState(() {
        isConnected = _appKitModal.isConnected;
      });
      log("On Disconnect: $event");
    });

    _appKitModal.onModalError.subscribe((ModalError? event) {
      setState(() {
        isConnected = _appKitModal.isConnected;
      });
      log("On Error: $event");
    });
  }

  @override
  void dispose() {
    // Remove the lifecycle observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This method is called when the app gains or loses focus
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log("Status ${ _appKitModal.isConnected}");
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        isConnected = _appKitModal.isConnected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        decoration: const BoxDecoration(
          color: UlaloColors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset("assets/images/ulalo.svg", width: 150)),
            verticalSpace(32),
            Center(child: Image.asset("assets/images/starter.png", width: MediaQuery.of(context).size.width * 0.75)),
            verticalSpace(24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Text(LocaleKeys.auth_starter_title, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20)).tr()
            ),
            verticalSpace(24),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(LocaleKeys.auth_starter_subtitle, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15)).tr()
            ),
          ],
        )
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 48, left: 24, right: 24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !isConnected,
                child: AppKitModalConnectButton(
                  appKit: _appKitModal,
                  custom: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.black
                      ),
                      onPressed: () async {
                        _appKitModal.openModalView();
                      },
                      child: const Row(
                        children: [
                          Icon(FluentIcons.wallet_32_regular),
                          Expanded(child: Center(child: Text('Connect Wallet'))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: isConnected,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home', // The new route to push
                            (Route<dynamic> route) => false, // Remove all previous routes
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Set your custom border radius here
                      ),
                      shadowColor: Colors.transparent,
                      backgroundColor: UlaloColors.primary,
                    ),
                    child: const Text(
                      LocaleKeys.auth_get_started,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ).tr(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void testDeepLink() async {
    const url = 'ulalo://'; // Replace with the full URL scheme if needed, like 'ulalo://path'
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
      print("Successfully launched: $url");
    } else {
      print("Unable to launch: $url");
    }
  }
}
