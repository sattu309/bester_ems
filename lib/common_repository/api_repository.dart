import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:ecom_demo/login_flow/bester_login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../resources/helper.dart';
import '../models/otpverify_model.dart';

String deviceId = "";

Future<String?> get fcmToken async => await FirebaseMessaging.instance.getToken();

class Repositories {

  static Future<OtpVerifyModel?> getLoginDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("user_info") != null) {
      return OtpVerifyModel.fromJson(jsonDecode(pref.getString('user_info')!));
    }
    return null;
  }

  static Future<String?> get fcmToken async => await FirebaseMessaging.instance.getToken();

  Future<dynamic> postApi({
    BuildContext? context,
    required String url,
    // bool? showLoader = false,
    bool? showMap = false,
    Function(int status, String response)? withStatus,
    bool? showResponse = true,
    Map<String, dynamic>? mapData,
  }) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    if (context != null) {
      Overlay.of(context).insert(loader);
    }

    OtpVerifyModel? model = await getLoginDetails();

    try {
      final Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        if (model != null) HttpHeaders.authorizationHeader: 'Bearer ${model.success!.token}'
      };
      mapData ??= {};

      if (kDebugMode) {
        log("API Url.....  $url");
        log("API mapData.....  $mapData");
        if (true) {
          log("API mapData.....  $headers");
        }
      }

      http.Response response = await http.post(Uri.parse(url), body: jsonEncode(mapData), headers: headers);

      if (kDebugMode) {
        if (showResponse == true) {
          log("API Response Url........  $url");
          log("API Response........  ${response.body}");
          log("API Response Status Code........  ${response.statusCode}");
          log("API Response Reason Phrase........  ${response.reasonPhrase}");
        }
      }


      Helpers.hideLoader(loader);

      if (response.statusCode == 200 || response.statusCode == 404 || response.statusCode == 400) {
        if (withStatus != null) {
          withStatus(response.statusCode, response.body);
        }
        return response.body;
      } else if (response.statusCode == 401) {
        // logOutUser();
        throw Exception(response.body);
      } else {
        Helpers.showToast(response.body);
        throw Exception(response.body);
      }
    } on SocketException catch (e) {
      Helpers.hideLoader(loader);
      Helpers.showToast("No Internet Access");
      throw Exception(e);
    } catch (e) {
      Helpers.hideLoader(loader);
      throw Exception(e);
    }
  }

  Future<dynamic> getApi({
    BuildContext? context,
    required String url,
    bool? showMap = true,
    bool? showResponse = true,
    bool? returnResponse = false,
    dynamic mapData,
  }) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    if (context != null) {
      Overlay.of(context).insert(loader);
    }

    OtpVerifyModel? model = await getLoginDetails();

    try {
      final Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        if (model != null) HttpHeaders.authorizationHeader: 'Bearer ${model.success!.token}'
      };
      mapData ??= {};

      if (kDebugMode) {
        log("API Url.....  $url");
        log("API mapData.....  $headers");
      }

      http.Response response = await http.get(Uri.parse(url), headers: headers);
      log("API Response........  ${response.body}");
      if (kDebugMode) {
        if (showResponse == true) {
          log("API Url.....  $url");
          log("API Response........  ${response.body}");
          log("API Response Status Code........  ${response.statusCode}");
          log("API Response Reason Phrase........  ${response.reasonPhrase}");
        }
      }

      Helpers.hideLoader(loader);
      if (returnResponse!) {
        return response;
      } else {
        if (response.statusCode == 200 || response.statusCode == 400) {
          return response.body;
        } else if (response.statusCode == 401) {
          // logOutUser();
        } else {
          // showToast(response.body);
          throw Exception(response.statusCode);
        }
      }
    } on SocketException {
      Helpers.hideLoader(loader);
      Helpers.showToast("No Internet Access");
      throw Exception("No Internet Access");
    } catch (e) {
      Helpers.hideLoader(loader);
      // showToast(e.toString());
      throw Exception(e);
    }
  }

  Future<dynamic> multiPartApi(
      {required mapData,
        required Map<String, File> images,
        BuildContext? context,
        required String url,
        required Function(int bytes, int totalBytes) onProgress}) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    if (context != null) {
      Overlay.of(context).insert(loader);
    }

    OtpVerifyModel? model = await getLoginDetails();

    try {
      final Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        if (model != null) HttpHeaders.authorizationHeader: 'Bearer ${model.success!.token}'
      };
      mapData ??= {};
      images.removeWhere((key, value) => value.path.contains("http"));
      var request = CloseableMultipartRequest('POST', Uri.parse(url), onProgress: (int bytes, int totalBytes) {
        if (images.isNotEmpty) {
          onProgress(bytes, totalBytes);
        }
      });

      request.headers.addAll(headers);

      request.fields.addAll(mapData);
      for (var item in images.entries) {
        if (item.value.path != "") {
          request.files.add(await _multipartFile(item.key.toString(), item.value));
        }
      }
      if (kDebugMode) {
        log(url);
        log(request.headers.toString());
        log(request.fields.toString());
        log(images.toString());
        log(request.files.map((e) => e.filename).toList().toString());
      }

      final response = await request.send();
      String value = await response.stream.bytesToString();
      log("Api Response.....      $value");
      log(response.statusCode.toString());
      Helpers.hideLoader(loader);
      if (response.statusCode == 200) {
        return value;
      } else if (response.statusCode == 401) {
        // logOutUser();
        throw Exception(value);
      } else {
        Helpers.hideLoader(loader);
        throw Exception(value);
      }
    } on SocketException catch (e) {
      Helpers.hideLoader(loader);
      Helpers.showToast("No Internet Access");
      throw Exception(e);
    } catch (e) {
      Helpers.hideLoader(loader);
      Helpers.showToast("Something went wrong.....${e.toString().substring(0, math.min(e.toString().length, 50))}");
      throw Exception(e);
    }
  }

  Future<http.MultipartFile> _multipartFile(String? fieldName, File file1) async {
    return http.MultipartFile(
      fieldName ?? 'file',
      http.ByteStream(Stream.castFrom(file1.openRead())),
      await file1.length(),
      filename: file1.path.split('/').last,
    );
  }

  Future<void> logOutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
   // showToast("Access denied");
    Get.offAll(()=>const BesterLoginPage());
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

class CloseableMultipartRequest extends http.MultipartRequest {
  http.Client client = http.Client();

  CloseableMultipartRequest(
      String method,
      Uri uri, {
        required this.onProgress,
      }) : super(method, uri);

  void close() => client.close();

  @override
  Future<http.StreamedResponse> send() async {
    try {
      var response = await client.send(this);
      var stream = onDone(response.stream, client.close);
      return http.StreamedResponse(
        http.ByteStream(stream),
        response.statusCode,
        contentLength: response.contentLength,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    } catch (_) {
      client.close();
      rethrow;
    }
  }

  final void Function(int bytes, int totalBytes) onProgress;

  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    // if (onProgress == null) return byteStream;

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        if (total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }

  Stream<T> onDone<T>(Stream<T> stream, void Function() onDone) =>
      stream.transform(StreamTransformer.fromHandlers(handleDone: (sink) {
        sink.close();
        onDone();
      }));
}