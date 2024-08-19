import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulalo/core/global.dart';
import 'package:ulalo/core/theme.dart';
import 'package:ulalo/generated/locale_keys.g.dart';

class StarterUi extends StatefulWidget {
  const StarterUi({Key? key}) : super(key: key);

  @override
  _StarterUiState createState() => _StarterUiState();
}

class _StarterUiState extends State<StarterUi> {
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
              child: Text(LocaleKeys.auth_starter_title, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20))
            ),
            verticalSpace(24),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(LocaleKeys.auth_starter_subtitle, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15))
            ),
          ],
        )
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        child: SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/auth");
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: UlaloColors.primary,
            ),
            child: const Text(
              LocaleKeys.auth_get_started,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
