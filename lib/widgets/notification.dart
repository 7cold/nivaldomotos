import 'package:http/http.dart' as http;

void enviarNotificacao() {
  String data =
      "{\"notification\": {\"body\": \"Nova compra efetuada!\"}, \"priority\": \"high\", \"data\": {\"click_action\": \"FLUTTER_NOTIFICATION_CLICK\", \"id\": \"1\", \"status\": \"done\"}, \"to\": \"/topics/allDevices\"}";
  http.post("https://fcm.googleapis.com/fcm/send", body: data, headers: {
    "Content-Type": "application/json",
    "Authorization":
        "key=AAAANaWg6rc:APA91bGN-yad0Ur2d5EMYyF_xdUsia2JAdQzhGHs2mJupX0osOZM2x6H4lg3KCazP16O_2l-HjoxUIFJzaOvUM75mew9jY35HSH7aHHFBgGK9XTkSdgtix2L3EO11Wj7g3-ooy1IFZY8"
  });
}
