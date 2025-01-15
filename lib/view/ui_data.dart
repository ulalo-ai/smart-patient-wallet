import 'dart:ui';
import 'package:path/path.dart' as path;
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ulalo/view/doc_preview.dart';
import 'package:reown_appkit/appkit_modal.dart';
import '../core/theme.dart';
import '../service/wallet.provider.dart';

class UiData extends StatefulWidget {
  const UiData({super.key, required this.appKitModal});

  final ReownAppKitModal appKitModal;

  @override
  _UiDataState createState() => _UiDataState();
}

class _UiDataState extends State<UiData> with WidgetsBindingObserver {

  getImage(String key){
    const icons = {
      "vaccine": "https://img.icons8.com/fluency/100/syringe.png",
      "vaccination": "https://img.icons8.com/fluency/100/syringe.png",
      "consultation": "https://img.icons8.com/external-flaticons-flat-flat-icons/100/external-medical-book-medical-and-healthcare-flaticons-flat-flat-icons.png",
      "examination": "https://img.icons8.com/fluency/100/lab-items.png",
      "analysis": "https://img.icons8.com/color/100/test-folder.png"
    };
    return icons[key] ?? "https://img.icons8.com/color/100/rh-plus.png";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletConnectProvider>(
        builder: (context, userProvider, child) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: userProvider.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : userProvider.myData == null
                  ? const Center(
                      child: Text("No items found"),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      // shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      reverse: true,
                      itemCount: userProvider.myData!.files!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // settings[index].updateActive();
                          },
                          child: Container(
                            child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Image.network(getImage(userProvider.myData!.files![index][2].toString().toLowerCase()), width: 35, height: 35,),
                                title: Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text(
                                            userProvider.myData!.files![index]
                                                [1],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 15))
                                        .tr()),
                                subtitle: Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text(
                                            userProvider.myData!.files![index]
                                                [0],
                                        maxLines: 1, // Limit to one lin
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: UlaloColors.textGrey800,
                                                fontSize: 12))
                                        .tr()),
                                trailing: IconButton(
                                    onPressed: () {
                                      final chainId = widget.appKitModal.selectedChain?.chainId ?? '';
                                      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
                                      final address = widget.appKitModal.session!.getAddress(namespace);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => DocPreview(cid: userProvider.myData!.files![index][0], address: address!,)),
                                      );
                                    },
                                    icon: const Icon(
                                      FluentIcons.send_24_filled,
                                      color: UlaloColors.primary,
                                    ))),
                          ),
                        );
                      },
                    ),
        ),
      );
    });
  }
}
