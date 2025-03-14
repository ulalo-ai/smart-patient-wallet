import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ulalo/core/global.dart';
import 'package:reown_appkit/appkit_modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

const API_HOST = "https://webappapiulaloview.azurewebsites.net";

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: API_HOST, // Replace with your API base URL
    connectTimeout: const Duration(seconds: 60), // Connection timeout
    receiveTimeout: const Duration(seconds: 60), // Receive timeout
  ));

  DioClient() {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,      // Log requests
        requestBody: true,  // Log request body
        requestHeader: true,// Log request headers
        responseHeader: true,// Log response headers
        responseBody: true,  // Log response body
        error: true,        // Log errors
        logPrint: (object) {
          // You can redirect the log to any logger of your choice, like print or custom log function
          if (kDebugMode) {
            log(object.toString());
          }
        },
      ),
    );
  }

  Dio get dio => _dio;
}

class DocData {
  String? date;
  List<dynamic> category;

  DocData({
    required this.date,
    required this.category
  });

  factory DocData.fromJson(Map<String, dynamic> json) {
    return DocData(
        date: json["date"],
        category: json["category"]
    );
  }

  Map<String, dynamic> toJson() => {
    "date": date,
    "text": category
  };
}

String messageModelToJson(DocData data) => json.encode(data.toJson());

DocData messageFromJson(String str) => DocData.fromJson(json.decode(str));




class IpfsData {
  String? Hash;
  String? Name;
  String? Size;

  IpfsData({
    required this.Hash,
    required this.Name,
    required this.Size
  });

  factory IpfsData.fromJson(Map<String, dynamic> json) {
    return IpfsData(
        Name: json["Name"],
        Hash: json["Hash"],
        Size: json["Size"]
    );
  }

  Map<String, dynamic> toJson() => {
    "Hash": Hash,
    "Size": Size,
    "Name": Name
  };
}

String ipfsModelToJson(IpfsData data) => json.encode(data.toJson());

IpfsData ipfsFromJson(String str) => IpfsData.fromJson(json.decode(str));




class ContractData {
  List<dynamic>? files;

  ContractData({
    required this.files
  });

  factory ContractData.fromJson(Map<String, dynamic> json) {
    return ContractData(
        files: json["files"]
    );
  }

  Map<String, dynamic> toJson() => {
    "files": files
  };
}

String contractModelToJson(ContractData data) => json.encode(data.toJson());

ContractData contractFromJson(String str) => ContractData.fromJson(json.decode(str));


class WalletConnectProvider with ChangeNotifier {

  FilePickerResult? _file;
  File? _pdfFile;
  bool _isUploading = false;
  bool _loading = false;
  String _uploadStatus = '';
  DocData? _docData;
  ContractData? _myData;
  IpfsData? _ipfsData;

  FilePickerResult? get file => _file;
  File? get pdfFile => _pdfFile;
  bool get isUploading => _isUploading;
  bool get loading => _loading;
  String get uploadStatus => _uploadStatus;
  DocData? get docData => _docData;
  ContractData? get myData => _myData;
  IpfsData? get ipfsData => _ipfsData;

  String status = "...";

  Future<void> pickPDFFile() async {
    _file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    File file = File(_file!.files.single.path!);
    if (_file!.files.single.extension == 'pdf') {
      _pdfFile = file;
    } else {
      // Check if the file is an image
      img.Image? image = img.decodeImage(file.readAsBytesSync());
      if (image != null) {
        _pdfFile = await _convertImageToPDF(file);
      } else {
        _pdfFile = null;
      }
    }
    // if (_file != null && _file!.files.isNotEmpty) {
    //   notifyListeners();
    // }
    if (_pdfFile != null) {
      notifyListeners();
    }
  }

  Future<void> captureImageFromCamera() async {
    // Initialize the image picker
    final ImagePicker picker = ImagePicker();
    // Capture an image from the camera
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    // Check if an image was captured
    if (image != null) {
      // Return the captured image as a File
      _pdfFile = await _convertImageToPDF(File(image.path));
      notifyListeners();
    }
  }

  Future<File> _convertImageToPDF(File imageFile) async {
    _isUploading = true;
    notifyListeners();
    // Create a PDF document
    final pdf = pw.Document();

    // Load the image
    final image = img.decodeImage(imageFile.readAsBytesSync());

    if (image != null) {
      // Add the image to a new PDF page
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(
                pw.MemoryImage(
                  imageFile.readAsBytesSync(),
                ),
                fit: pw.BoxFit.cover,
              ),
            );
          },
        ),
      );

      // Save the PDF file
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File pdfFile = File('$tempPath/converted_image.pdf');
      await pdfFile.writeAsBytes(await pdf.save());
      _isUploading = false;
      notifyListeners();
      return pdfFile;
    } else {
      _isUploading = false;
      notifyListeners();
      throw Exception('Error decoding the image file');
    }
  }

  Future<void> uploadPDFFile(String address) async {
    if (_pdfFile != null) {
      try {
        _isUploading = true;
        _uploadStatus = "Uploading...";
        notifyListeners();
        String filePath = _pdfFile!.path;
        FormData formData = FormData.fromMap({
          "pdfFile": await MultipartFile.fromFile(filePath, filename: path.basename(filePath)),
        });
        DioClient api = DioClient();
        status = "Analyzing file ....";
        notifyListeners();
        Response response = await api.dio.post(
          "$API_HOST/api/extract-data",
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
        );
        status = response.statusCode == 200 ? "Analysis done!" : "Analysis failed!";
        notifyListeners();
        // _uploadStatus = response.statusCode == 200 ? "Upload successful!" : "Upload failed!";
        _docData = DocData.fromJson(response.data);

        log("==============================================================================");
        log(filenameFromAPI(_docData?.category.cast<String>() ?? []));
        log("==============================================================================");

        FormData formData2 = FormData.fromMap({
          "path": await MultipartFile.fromFile(filePath, filename: filenameFromAPI(_docData?.category.cast<String>() ?? []) + path.extension(filePath)),
        });

        log("==============================================================================");
        log(path.basenameWithoutExtension(filePath));
        log(path.extension(filePath));
        log("==============================================================================");

        status = "Uploading ...";
        notifyListeners();
        Response response2 = await api.dio.post(
          "$IPFS_HOST/api/v0/add/",
          data: formData2,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
              "Authorization": "Basic $IPFS_AUTH"
            },
          ),
        );
        status = response2.statusCode == 200 ? "Upload file!" : "Upload failed!";
        notifyListeners();
        // _uploadStatus = response2.statusCode == 200 ? "Upload successful!" : "Upload failed!";
        _ipfsData = IpfsData.fromJson(response2.data);
        log(_ipfsData.toString());

        status = "Storing Analysis Data...";
        notifyListeners();
        final Map<String, dynamic> payload = {
          "fileName": filenameFromAPI(_docData?.category.cast<String>() ?? []) + path.extension(filePath),
          "fileType": getCategory(_docData?.category.cast<String>() ?? []),
          "userAddress": address,
          "cid": _ipfsData?.Hash.toString()
        };
        Response response3 = await api.dio.post(
          "$CONTRACT_API/store/",
          data: payload,
          options: Options(
            headers: {
              "Content-Type": "application/json"
            },
          ),
        );

        // Log the response or inform the user
        if (response3.statusCode == 200) {
          log("==============================================================================");
          log("File stored successfully: ${response.data}");
          log("==============================================================================");
        } else {
          log("Failed to store file: ${response.statusCode} - ${response.data}");
        }
        status = response3.statusCode == 200 ? "Analysis Data Stored!" : "Error storing data";
        notifyListeners();
      } catch (e) {
        _docData = null;
        _uploadStatus = "Error occurred during upload: $e";
        log("Error: ${e.toString()}");
        notifyListeners();
      } finally {
        _isUploading = false;
        notifyListeners();
      }
    }
  }

  Future<void> getUserData(String address) async {
    DioClient api = DioClient();
    _loading = true;
    notifyListeners();
    try {
      Response response = await api.dio.get(
        "$CONTRACT_API/data/${address}",
        options: Options(
          headers: {
            "Content-Type": "application/json"
          },
        ),
      );

      log("==============================================================================");
      log("==============================================================================");
      _myData = ContractData.fromJson(response.data);
      log("==============================================================================");
      log("==============================================================================");
      notifyListeners();
    } catch (e) {
      _myData = null;
      log("Error: ${e.toString()}");
      notifyListeners();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  int _activeTab = 0;
  int get activeTab => _activeTab;

  Future<void> changeTab(int tab, ReownAppKitModal widget) async { // Define async function
    notifyListeners();
    _activeTab = tab;
    if(tab == 1){
      final chainId = widget.selectedChain?.chainId ?? '';
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
      final address = widget.session!.getAddress(namespace);
      getUserData(address!);
    }
    notifyListeners();
  }

  void _initializeListeners() {
  }

}
