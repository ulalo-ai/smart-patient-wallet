
import 'package:dotted_separator/dotted_separator.dart';
import 'package:reown_appkit/reown_appkit.dart';

ReownAppKitModal web3Credentials(BuildContext ctx){
  return ReownAppKitModal(
      context: ctx,
      projectId: '821b4e69a03f6264d8f6c14577a601dc',
      metadata: const PairingMetadata(
        name: 'Ulalo Med',
        description: 'Ulalo Medical Web3 App',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'ulalo://',
          universal: 'https://www.ulalo.xyz',
        ),
      )
  );
}