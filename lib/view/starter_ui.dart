import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reown_appkit/modal/widgets/public/appkit_modal_account_button.dart';
import 'package:reown_appkit/modal/widgets/public/appkit_modal_connect_button.dart';
import 'package:reown_appkit/modal/widgets/public/appkit_modal_network_select_button.dart';
import 'package:ulalo/core/global.dart';
import 'package:ulalo/core/theme.dart';
import 'package:ulalo/generated/locale_keys.g.dart';

import '../core/creds.dart';

class StarterUi extends StatefulWidget {
  const StarterUi({Key? key}) : super(key: key);

  @override
  _StarterUiState createState() => _StarterUiState();
}

class _StarterUiState extends State<StarterUi> with WidgetsBindingObserver {

  var _appKitModal;
  late bool isConnected;

  @override
  void initState() {
    _appKitModal = web3Credentials(context);
    Future.microtask(() async {
      await _appKitModal.init();
    });
    setState(() {
      isConnected = _appKitModal.isConnected;
    });
    super.initState();
    // Register this widget as a lifecycle observer
    WidgetsBinding.instance.addObserver(this);
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
    setState(() {
      isConnected = _appKitModal.isConnected;
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
        padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !_appKitModal.isConnected,
                child: AppKitModalConnectButton(appKit: _appKitModal),
              ),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _appKitModal.isConnected,
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
}
