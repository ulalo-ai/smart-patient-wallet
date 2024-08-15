import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ulalo/core/global.dart';
import 'package:ulalo/core/theme.dart';

import 'package:ulalo/generated/locale_keys.g.dart';

class AuthUi extends StatefulWidget {
  const AuthUi({Key? key}) : super(key: key);

  @override
  _AuthUiState createState() => _AuthUiState();
}

class _AuthUiState extends State<AuthUi> {

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
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(LocaleKeys.auth_sign_in_up, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 32)).tr()
                      ),
                      verticalSpace(64),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            backgroundColor: UlaloColors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Image.asset(
                                    'assets/images/metamask.png',
                                    height: 24.0,
                                    width: 24.0
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Center(
                                  child: Text(
                                    LocaleKeys.auth_sign_mm,
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
                                  ).tr(),
                                ),
                              ),
                            ],
                          ),

                        ),
                      )
                    ],
                  )
              ),
            ]
        )
    );
  }
}
