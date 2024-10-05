
import 'package:reown_appkit/reown_appkit.dart';

final w3mService = ReownAppKit.createInstance(
  projectId: '821b4e69a03f6264d8f6c14577a601dc',
  metadata: const PairingMetadata(
    name: 'Ulalo Med',
    description: 'Web3Modal Flutter Example',
    url: 'https://www.walletconnect.com/',
    icons: ['https://walletconnect.com/walletconnect-logo.png'],
    redirect: Redirect(
      native: 'ulalo://',
      universal: 'https://www.ulalo.xyz',
    ),
  )
);