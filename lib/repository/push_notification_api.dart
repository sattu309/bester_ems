import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendPushNotification(
    {required String deviceToken,
      required String title,
      required String body,
    }) async {
  const String serverKey =
      'AAAALUrjSRk:APA91bHKgvEYeBQiLB3k4PZHgvi4eejnE15Ru48vSVGw7NXdq0CRLBIkQmn-Vy3y4KFI3o8OXgcWet_hpBjmHMB_aE5Hsg29tuQvj53QT2KrXe6UeKdaaaEnlHDTG7oPiv2Xytoo5qUP';

  final Map<String, dynamic> notification = {
    'body': body,
    'title': title,
    "sound": "ring.wav",
    'android_channel_id': '',
    //'image': image,
  };

  final Map<String, dynamic> message =

    {
      "to":deviceToken,
      "notification":{
        "title": "Emergency Alert",
        "body": "Hey sound check",
        "android_channel_id": "",
        "sound": "ring.wav"
      },
      "android": {
        "notification": {
          "channel_id": "channel_id_1",
          "priority":"high",
          "ttl":"300s"
        }
      }

  };

  try {
    final http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
      print(response.body);
    } else {
      print('Failed to send notification. Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error sending notification: $e');
  }
}
