// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "auth": {
    "starter_title": "The Decentralized Smart Patient Wallet.",
    "starter_subtitle": "Take Control of Your Medical Records. Your Unhackable Health Wallet is here.",
    "get_started": "Get Started",
    "auth_desc": "Connect to a Web3 Wallet to authenticate and start using our app",
    "sign_up": "Sign Up with Web3 ID",
    "sign_in": "Sign In with Web3 ID",
    "sign_mm": "Connect Wallet",
    "sign_meta_title": "Sign In with your\nMeta Mask Account",
    "sign_meta_desc": "Scan the QR Code or click the button to sign in with your ID using MetaMask",
    "signup_quest": "Don't have an account?",
    "signup": "Sign Up",
    "error_conn": "Error while connecting wallet"
  }
};
static const Map<String,dynamic> fr = {
  "auth": {}
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fr": fr};
}
