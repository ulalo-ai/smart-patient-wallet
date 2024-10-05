import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'global.dart';

class UlaloColors {
  UlaloColors._();
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Colors.transparent;
  static const primary = Color(0xFF1BE866);
  static const primaryInfo = Color(0xFF8DF4B2);
  static const primaryBg = Color(0xFFC6F9D9);
  static const secondary = Color(0xFF354755);
  static const secondaryInfo = Color(0xFF7AA8B7);
  static const secondaryBg = Color(0xFFDEE9ED);
  static const info = Color(0xFF007bff);
  static const success = Color(0xFF12D18E);
  static const error = Color(0xFFF75555);
  static const lightDisabled = Color(0xFFD8D8D8);
  static const darkDisabled = Color(0xFF23252B);
  static const btnDisabled = Color(0xFF0A9B4C);
  static const warning = Color(0xFFFACC15);
  static const bg = Color(0xFFF5F5F5);
  static const textGrey900 = Color(0xFF212121);
  static const textGrey800 = Color(0xFF424242);
  static const textGrey700 = Color(0xFF616161);
  static const textGrey600 = Color(0xFF757575);
  static const textGrey500 = Color(0xFF9E9E9E);
  static const textGrey400 = Color(0xFFBDBDBD);
  static const textGrey300 = Color(0xFFE0E0E0);
  static const textGrey200 = Color(0xFFEEEEEE);
  static const textGrey100 = Color(0xFFE5E5E5);
  static const textGrey50 = Color(0xFFFAFAFA);
  static const surfaceBtnLight = Color(0xFFECFAF2);
}

class UlaloTypography {
  UlaloTypography();

  //fonts
  static const String family = 'Poppins';
  //weights
  static const FontWeight weightThin = FontWeight.w100;
  static const FontWeight weightExtraLight = FontWeight.w200;
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightExtraBold = FontWeight.w800;
  // sizes
  static double size_8 = Sizes.size_8;
  static double size_10 = Sizes.size_10;
  static double size_12 = Sizes.size_12;
  static double size_14 = Sizes.size_14;
  static double size_16 = Sizes.size_16;
  static double size_18 = Sizes.size_18;
  static double size_20 = Sizes.size_20;
  static double size_24 = Sizes.size_24;
  static double size_28 = Sizes.size_28;
  static double size_30 = Sizes.size_30;
  static double size_32 = Sizes.size_32;
  static double size_40 = Sizes.size_40;
  static double size_48 = Sizes.size_48;
  static double size_54 = Sizes.size_54;
  static double size_60 = Sizes.size_60;
  static double size_72 = Sizes.size_72;

  //text styles

  //headings
  static TextStyle headingH1 = TextStyle(
    fontFamily: family,
    fontWeight: weightBold, // 700
    fontSize: size_48,
    color: UlaloColors.textGrey900,
  );

  static TextStyle headingH2 = TextStyle(
    fontFamily: family,
    fontWeight: weightBold, // 700
    fontSize: size_40, color: UlaloColors.textGrey900,
  );

  static TextStyle headingH3 = TextStyle(
    fontFamily: family,
    fontWeight: weightBold, // 700
    fontSize: size_32, color: UlaloColors.textGrey900,
  );

  static TextStyle headingH4 = TextStyle(
    fontFamily: family,
    fontWeight: weightBold, // 700
    fontSize: size_24, color: UlaloColors.textGrey900,
  );

  static TextStyle headingH5 = TextStyle(
    fontFamily: family,
    fontWeight: weightSemiBold, // 600
    fontSize: size_20, color: UlaloColors.textGrey900,
  );

  static TextStyle headingH6 = TextStyle(
    fontFamily: family,
    fontWeight: weightSemiBold, // 600
    fontSize: size_24,
    color: UlaloColors.textGrey900,
  );
//body xlarge
  static TextStyle bodyXLargeBold = TextStyle(
    fontFamily: family,
    fontWeight: weightBold, // 700
    fontSize: size_18,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyXLargeSemibold = TextStyle(
    fontFamily: family,
    fontWeight: weightSemiBold, // 600
    fontSize: size_18,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyXLargeMedium = TextStyle(
    fontFamily: family,
    fontWeight: weightMedium, // 500
    fontSize: size_18,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyXLargeRegular = TextStyle(
    fontFamily: family,
    fontWeight: weightRegular, // 400
    fontSize: size_18,
    color: UlaloColors.textGrey700,
  );

  //body large
  static TextStyle bodyLargeBold = TextStyle(
    fontFamily: family,
    fontWeight: weightBold, // 700
    fontSize: size_16,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyLargeSemibold = TextStyle(
    fontFamily: family,
    fontWeight: weightSemiBold, // 600
    fontSize: size_16,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyLargeMedium = TextStyle(
    fontFamily: family,
    fontWeight: weightMedium, // 500
    fontSize: size_16,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyLargeRegular = TextStyle(
    fontFamily: family,
    fontWeight: weightRegular, // 400
    fontSize: size_16,
    color: UlaloColors.textGrey700,
  );
//body medium
  static TextStyle bodyMediumBold = TextStyle(
    fontFamily: family,
    fontWeight: weightBold, // 700
    fontSize: size_14,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyMediumSemibold = TextStyle(
    fontFamily: family,
    fontWeight: weightSemiBold, // 600
    fontSize: size_14,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyMediumMedium = TextStyle(
    fontFamily: family,
    fontWeight: weightMedium, // 500
    fontSize: size_14,
    color: UlaloColors.textGrey700,
  );

  static TextStyle bodyMediumRegular = TextStyle(
    fontFamily: family,
    fontWeight: weightRegular, // 400
    fontSize: size_14,
    color: UlaloColors.textGrey700,
  );

  //body small
  static TextStyle bodySmallBold = TextStyle(
    fontFamily: family,
    fontWeight: weightBold, // 700
    fontSize: size_12,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodySmallSemibold = TextStyle(
    fontFamily: family,
    fontWeight: weightSemiBold, // 600
    fontSize: size_12,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodySmallMedium = TextStyle(
    fontFamily: family,
    fontWeight: weightMedium, // 500
    fontSize: size_12,
    color: UlaloColors.textGrey700,
  );

  static TextStyle bodySmallRegular = TextStyle(
    fontFamily: family,
    fontWeight: weightRegular, // 400
    fontSize: size_12,
    color: UlaloColors.textGrey700,
  );
//body xsmall
  static TextStyle bodyXSmallBold = TextStyle(
    fontFamily: family,
    fontWeight: weightBold, // 700
    fontSize: size_10,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyXSmallSemibold = TextStyle(
    fontFamily: family,
    fontWeight: weightSemiBold, // 600
    fontSize: size_10,
    color: UlaloColors.textGrey700,
  );
  static TextStyle bodyXSmallMedium = TextStyle(
    fontFamily: family,
    fontWeight: weightMedium, // 500
    fontSize: size_10,
    color: UlaloColors.textGrey700,
  );

  static TextStyle bodyXSmallRegular = TextStyle(
    fontFamily: family,
    fontWeight: weightRegular, // 400
    fontSize: size_10,
    color: UlaloColors.textGrey700,
  );
}

ThemeData UlaloTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: UlaloColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: UlaloColors.primary,
      primary: UlaloColors.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        textStyle: GoogleFonts.poppins(
          fontSize: 14, // Size
          fontWeight: FontWeight.bold, // Weight
        ),
        backgroundColor: UlaloColors.primary,
        foregroundColor: Colors.white,
        disabledForegroundColor: UlaloColors.textGrey500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        fixedSize: const Size.fromHeight(45),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          disabledBackgroundColor: UlaloColors.textGrey300,
          disabledForegroundColor: UlaloColors.textGrey500,
        )),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Urbanist',
        ),
        backgroundColor: Colors.white,
        foregroundColor: UlaloColors.primary,
        disabledForegroundColor: UlaloColors.textGrey500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: UlaloColors.primary, width: 2),
        ),
        fixedSize: const Size.fromHeight(45),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      fillColor: Colors.grey[200],
      border: const OutlineInputBorder(
        borderSide: BorderSide(width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: UlaloColors.textGrey500,
          width: 3,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: UlaloColors.textGrey500,
          width: 3,
        ),
      ),
      isDense: false,
      iconColor: Colors.red,
    ),
    appBarTheme: const AppBarTheme(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
    tabBarTheme: const TabBarTheme(
      dividerColor: UlaloColors.textGrey300,
      unselectedLabelColor: Colors.black,
      overlayColor: MaterialStatePropertyAll(Colors.white),
      labelPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: 'Urbanist',
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins'
);
