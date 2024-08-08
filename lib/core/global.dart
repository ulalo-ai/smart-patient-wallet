import 'package:flutter/material.dart';

Widget verticalSpace(double height) {
  return SizedBox(height: height);
}

Widget horizontalSpace(double width) {
  return SizedBox(width: width);
}

class AppNavigator {
  AppNavigator._();

  static Future<dynamic> push(
      BuildContext context,
      Widget screen,
      ) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => screen));
  }

  static Future<dynamic> pushNamed(
      BuildContext context,
      String route,
      ) {
    return Navigator.of(context).pushNamed(route);
  }

  static Future<dynamic> pushReplacement(BuildContext context, Widget screen) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

  static void pop(BuildContext context, [dynamic data]) {
    return Navigator.of(context).pop(data);
  }

  static void popUntilFirst(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static Future<dynamic> removeAllPreviousAndPush(
      BuildContext context,
      Widget screen,
      ) {
    return Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute(builder: (context) => screen),
          (route) => false,
    );
  }
}

class Sizes {
  static late BuildContext _context;

  static void init(BuildContext context) {
    _context = context;
  }

  static double getSize(double size) {
    final double screenWidth = MediaQuery.of(_context).size.width;
    final double screenHeight = MediaQuery.of(_context).size.height;
    final double scaleFactor =
    screenWidth < screenHeight ? screenHeight / 852 : screenWidth / 393;
    return size * scaleFactor;
  }

  static double get size_2 => getSize(2);
  static double get size_4 => getSize(4);
  static double get size_6 => getSize(6);
  static double get size_8 => getSize(8);
  static double get size_10 => getSize(10);
  static double get size_12 => getSize(12);
  static double get size_14 => getSize(14);
  static double get size_16 => getSize(16);
  static double get size_18 => getSize(18);
  static double get size_20 => getSize(20);
  static double get size_22 => getSize(22);
  static double get size_24 => getSize(24);
  static double get size_28 => getSize(28);
  static double get size_30 => getSize(30);
  static double get size_32 => getSize(32);
  static double get size_40 => getSize(40);
  static double get size_42 => getSize(42);
  static double get size_44 => getSize(44);
  static double get size_46 => getSize(46);
  static double get size_48 => getSize(48);
  static double get size_50 => getSize(50);
  static double get size_54 => getSize(54);
  static double get size_60 => getSize(60);
  static double get size_64 => getSize(64);
  static double get size_72 => getSize(72);
  static double get size_80 => getSize(80);
  static double get size_90 => getSize(90);
  static double get size_100 => getSize(100);
  static double get size_120 => getSize(120);
  static double get size_130 => getSize(130);
  static double get size_150 => getSize(150);
  static double get size_178 => getSize(178);
  static double get size_190 => getSize(190);
  static double get size_210 => getSize(210);
  static double get size_214 => getSize(214);
  static double get size_220 => getSize(220);
  static double get size_230 => getSize(230);
  static double get size_240 => getSize(240);
  static double get size_260 => getSize(260);
  static double get size_280 => getSize(280);
  static double get size_300 => getSize(300);
  static double get size_340 => getSize(340);
  static double get size_360 => getSize(360);
  static double get size_380 => getSize(380);
  static double get size_400 => getSize(400);
  static double get size_420 => getSize(420);
  static double get size_440 => getSize(440);
  static double get size_460 => getSize(460);
  static double get size_480 => getSize(480);
  static double get size_500 => getSize(500);
  static double get size_550 => getSize(550);
  static double get size_570 => getSize(570);
  static double get size_600 => getSize(600);
  static double get size_890 => getSize(890);
}

extension EmptySpace on num {
  Widget get pH => SizedBox(height: toDouble());
  Widget get pW => SizedBox(width: toDouble());
}

