import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../core/global.dart';

class DocPreview extends StatefulWidget {
  const DocPreview({super.key, required this.cid, required this.address});

  final String cid;
  final String address;

  @override
  _DocPreviewState createState() => _DocPreviewState();
}


class PdfDownloader {
  final Dio _dio = Dio();

  Future<String?> downloadPdf(String ipfsUrl, String bearerToken) async {
    try {
      // Get the temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Define the file path where the PDF will be saved
      String filePath = '$tempPath/document.pdf';

      // Set up headers with the Bearer token
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
        responseType: ResponseType.bytes, // For downloading as binary (PDF)
      );

      // Download the file
      Response response = await _dio.get(
        ipfsUrl,
        options: options,
      );

      // Save the file to the temporary directory
      File file = File(filePath);
      await file.writeAsBytes(response.data);

      print('File saved at: $filePath');
      return filePath;
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }
}


class _DocPreviewState extends State<DocPreview> {
  String pathPDF = "";

  bool _isLoading = true;

  File? _pdfFile;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final file = await createFileOfPdfUrl(widget.cid);
      setState(() {
        _pdfFile = file; // Assign the decrypted file
      });
    } catch (e) {
      log('Error loading PDF: $e');
    }
  }

  Future<File> createFileOfPdfUrl(String cid) async {
    Completer<File> completer = Completer();
    log("Start downloading file from IPFS!");

    try {
      final String url = "$CONTRACT_API/fetch/${widget.address}/${widget.cid}";
      final String filename = cid; // Use CID as the filename or customize it

      Dio dio = Dio();

      // Set up options with Bearer token for authentication
      Options options = Options(
        headers: {
          'Authorization': 'Basic $IPFS_AUTH',
        },
        responseType: ResponseType.bytes
      );

      // Send the GET request
      Response response = await dio.get(
        url,
        options: options,
      );

      // Convert response data to bytes
      var bytes = response.data;


      var dir = await getTemporaryDirectory();

      log("Download complete");
      log("${dir.path}/$filename.pdf");
      File file = File("${dir.path}/$filename.pdf");
      await file.writeAsBytes(bytes, flush: true);

      // Complete the future with the file
      completer.complete(file);
    } catch (e) {
      log('Error downloading PDF file: $e');
      completer.completeError(Exception('Error downloading PDF file: $e'));
    }

    return completer.future;
  }

  Future<void> shareFile() async {
    try {
      await Share.shareXFiles([XFile(pathPDF)], text: 'Check out this file!');
    } catch (e) {
      print('Error sharing file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    log("File path: $pathPDF");

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            widget.cid,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.share),
            onPressed: () => shareFile(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _pdfFile == null
          ? const Center(child: CircularProgressIndicator())
          : SfPdfViewer.file(_pdfFile!),
    );
  }
}
