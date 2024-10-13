import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:path/path.dart' as path;
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:ulalo/core/global.dart';
import 'package:ulalo/view/doc_preview.dart';
import 'package:web3modal_flutter/widgets/avatars/w3m_account_avatar.dart';
import 'package:web3modal_flutter/widgets/w3m_account_button.dart';

import '../core/creds.dart';
import '../core/theme.dart';
import '../generated/locale_keys.g.dart';
import '../service/wallet.provider.dart';

class UiDocIa extends StatefulWidget {
  const UiDocIa({Key? key}) : super(key: key);

  @override
  _UiDocIaState createState() => _UiDocIaState();
}

class _UiDocIaState extends State<UiDocIa> with WidgetsBindingObserver {
  String pathPDF = "";

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      const url =
          "https://u0lzv3m0jx-u0i2s1k0i5-ipfs.us0-aws.kaleido.io/ipfs/QmeVPegfqi6Xfq6anfCfKdFtuHpFxkqk7RTdxt4cPGhh88";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletConnectProvider>(
        builder: (context, userProvider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          children: [
            Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height, // Constrain height
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(24))),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
                        child: Column(
                          children: [
                            const Text(
                              "Medical Document Analyzer",
                              style: TextStyle(
                                  color: UlaloColors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                            verticalSpace(12),
                            const Divider(
                              color: UlaloColors.textGrey300,
                            ),
                            verticalSpace(8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "File to Upload (Image or PDF)",
                                    style: TextStyle(
                                        color: CupertinoColors.systemGrey,
                                        fontSize: 12),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            userProvider.pickPDFFile();
                                          },
                                          icon: const Icon(CupertinoIcons.folder,
                                              color: Colors.black, size: 32)),
                                      horizontalSpace(16),
                                      IconButton(
                                          onPressed: () {
                                            userProvider.captureImageFromCamera();
                                          },
                                          icon: const Icon(CupertinoIcons.camera,
                                              color: Colors.black, size: 32)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (userProvider.pdfFile != null)
                              Column(
                                children: [
                                  verticalSpace(12),
                                  const Divider(
                                    color: UlaloColors.textGrey300,
                                  ),
                                  verticalSpace(8),
                                  const Text(
                                    "Selected file:",
                                    style: TextStyle(
                                        color: UlaloColors.textGrey600,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  verticalSpace(10),
                                  Text(
                                    path.basename(userProvider.pdfFile!.path),
                                    style: const TextStyle(
                                        color: UlaloColors.info,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                      verticalSpace(16),
                    ],
                  ),
                )
            ),
            if (userProvider.isUploading)
              const CircularProgressIndicator(
                color: UlaloColors.primary,
              )
            else
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: userProvider.pdfFile != null
                      ? () async {
                          await userProvider.uploadPDFFile();
                          if(context.mounted){
                            if(userProvider.docData != null){
                              log(userProvider.docData.toString());
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return DraggableScrollableSheet(
                                        expand: true,
                                        builder: (BuildContext context, ScrollController scrollController) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom, // Adjust padding based on the keyboard height
                                            ),
                                            child: SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.75,
                                              child: Stack(
                                                children: <Widget>[
                                                  BackdropFilter(
                                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.black.withOpacity(0.1),
                                                      ),
                                                    ),
                                                  ),
                                                  BackdropFilter(
                                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                    child: Container(
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        color: Colors.transparent,
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(16), topRight: Radius.circular(16)), // Set the desired radius here
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(context).unfocus();
                                                        },
                                                        child: Scaffold(
                                                          resizeToAvoidBottomInset: false,
                                                          appBar: AppBar(
                                                            title: Center(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 5,
                                                                    width: 40,
                                                                    margin:
                                                                    const EdgeInsets.symmetric(vertical: 10),
                                                                    decoration: BoxDecoration(
                                                                      color: const Color(0xFFCCCCCC),
                                                                      borderRadius: BorderRadius.circular(10),
                                                                    ),
                                                                  ),
                                                                  verticalSpace(12),
                                                                  const Text(
                                                                    'Analyse du Document',
                                                                    style: TextStyle(
                                                                        fontSize: 18.0,
                                                                        color: Color(0xFF007BFF),
                                                                        fontWeight: FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            leading: Container(),
                                                            automaticallyImplyLeading: false,
                                                            leadingWidth: 0, // <-- Use this
                                                            centerTitle: true,
                                                          ),
                                                          body: SingleChildScrollView(
                                                            controller: scrollController,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Stack(
                                                                  clipBehavior: Clip.none,
                                                                  children: [
                                                                    Container(
                                                                      decoration: const BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(20),
                                                                          topRight: Radius.circular(20),
                                                                        ),
                                                                      ),
                                                                      child: Container(
                                                                        width: double.infinity,
                                                                        // height: MediaQuery.of(context).size.height * 0.475,
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal: 0, vertical: 0),
                                                                        child: Column(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                          children: [
                                                                            verticalSpace(16),
                                                                            Image.network("https://img.icons8.com/fluency/100/thin-test-tube.png", width: 100, height: 100),
                                                                            verticalSpace(24),
                                                                            if(userProvider.ipfsData != null)
                                                                              SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.75, // Set the width to 75% of the available width
                                                                                child: Text(
                                                                                  userProvider.ipfsData!.Hash!,
                                                                                  maxLines: 1, // Limit to one line
                                                                                  overflow: TextOverflow.ellipsis, // Add ellipsis when the text overflows
                                                                                  style: const TextStyle(fontSize: 16, color: Colors.black), // Customize text style
                                                                                ),
                                                                              ),
                                                                              verticalSpace(32),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (context) => DocPreview(cid: userProvider.ipfsData!.Hash!)),
                                                                                      );
                                                                                    },
                                                                                    child: Container(
                                                                                      padding: const EdgeInsets.all(6),
                                                                                      width: 100,
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Color(0xFFEEEEEE), borderRadius: BorderRadius.all(Radius.circular(8))
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          const Icon(FluentIcons.eye_32_regular, size: 16,),
                                                                                          horizontalSpace(6),
                                                                                          const Text("Voir", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  verticalSpace(16),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      Clipboard.setData(ClipboardData(text: userProvider.ipfsData!.Hash!));
                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        const SnackBar(content: Text('CID du Document copié')),
                                                                                      );
                                                                                    },
                                                                                    child: Container(
                                                                                      width: 100,
                                                                                      padding: const EdgeInsets.all(6),
                                                                                      decoration: const BoxDecoration(
                                                                                          color: Color(0xFFEEEEEE), borderRadius: BorderRadius.all(Radius.circular(8))
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          const Icon(FluentIcons.copy_32_regular, size: 16,),
                                                                                          horizontalSpace(6),
                                                                                          const Text("Copier", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            verticalSpace(32),
                                                                            Container(
                                                                                width: double.infinity,
                                                                                padding:
                                                                                const EdgeInsets.symmetric(
                                                                                    horizontal: 16,
                                                                                    vertical: 6),
                                                                                decoration: const BoxDecoration(
                                                                                    color: Colors.black),
                                                                                child: const Text(
                                                                                  "Résultat de l'analyse",
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 14,
                                                                                      color: Colors.white),
                                                                                )),
                                                                            verticalSpace(16),
                                                                            SingleChildScrollView(
                                                                              scrollDirection: Axis.vertical,
                                                                              child: Container(
                                                                                height: userProvider.docData!.category.length * 50 + 50,
                                                                                color: Colors.white,
                                                                                child: ListView.separated(
                                                                                  // physics: const NeverScrollableScrollPhysics(), // Disable ListView scrolling
                                                                                  // shrinkWrap: true,
                                                                                  itemCount: userProvider.docData!.category.length,
                                                                                  separatorBuilder: (context, index) {
                                                                                    return const Divider(
                                                                                      color: UlaloColors.textGrey300,
                                                                                    );
                                                                                  },
                                                                                  itemBuilder: (context, index) {
                                                                                    final data = userProvider.docData!.category[index];
                                                                                    return SizedBox(
                                                                                      height: 50,
                                                                                      child: ListTile(
                                                                                        title: Text(capitalize(data), style: const TextStyle(color: Colors.black)),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          bottomNavigationBar: Container(
                                                            decoration: const BoxDecoration(
                                                              color: Colors.white,
                                                              border: Border(
                                                                top: BorderSide(
                                                                  color: Color(0xFFFFAB00), // Color of the top border
                                                                  width: 2.0, // Width of the top border
                                                                ),
                                                              ),
                                                            ),
                                                            height: 90,
                                                            padding: const EdgeInsets.only(left: 16, right: 16),
                                                            child: Column(
                                                              children: [
                                                                verticalSpace(12),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child: SizedBox(
                                                                        height: 50,
                                                                        child: ElevatedButton.icon(
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          style: ElevatedButton.styleFrom(
                                                                              backgroundColor: UlaloColors.primary,
                                                                              elevation: 0),
                                                                          label: const Text("Fermer",
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight.bold, color: Colors.black,
                                                                                  fontSize: 16)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                verticalSpace(12),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  });
                            }
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Set your custom border radius here
                    ),
                    shadowColor: Colors.transparent,
                    backgroundColor: UlaloColors.primary,
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Analyze Document",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      Icon(
                        FluentIcons.send_28_filled,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
