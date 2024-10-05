import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ulalo/core/global.dart';
import 'package:ulalo/core/theme.dart';

import 'package:ulalo/generated/locale_keys.g.dart';
import 'package:web3modal_flutter/services/w3m_service/events/w3m_events.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:web3modal_flutter/widgets/w3m_account_button.dart';
import 'package:web3modal_flutter/widgets/w3m_connect_wallet_button.dart';
import 'package:web3modal_flutter/widgets/w3m_network_select_button.dart';

import '../core/creds.dart';

class AuthUi extends StatefulWidget {
  const AuthUi({Key? key}) : super(key: key);

  @override
  _AuthUiState createState() => _AuthUiState();
}

class _AuthUiState extends State<AuthUi> {

  @override
  void initState() {
    // TODO: implement initState
    // w3mService.onModalConnect.subscribe((ModalConnect? event) {
    //   if(event != null){
    //     ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    //       content: const Text(LocaleKeys.auth_error_conn).tr(),
    //     ));
    //   }
    //   else{
    //     ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    //       content: const Text(LocaleKeys.auth_error_conn).tr(),
    //     ));
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/bg.png'), // Add your background image here
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  top: 0,
                  child: SizedBox(
                      width: 150,
                      child: SvgPicture.asset("assets/images/auth.svg")
                  )
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: SvgPicture.asset("assets/images/ulalo.svg", width: 150)),
                      verticalSpace(48),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(LocaleKeys.auth_auth_desc, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: UlaloColors.textGrey600)).tr()
                      ),
                      verticalSpace(64),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // W3MAccountButton(service: w3mService),
                          // W3MNetworkSelectButton(service: w3mService),
                          // W3MConnectWalletButton(
                          //   service: w3mService, size: BaseButtonSize.big,
                          // ),
                        ],
                      ),
                    ],
                  )
              ),
            ]
        )
    );
  }
}
