import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:string_validator/string_validator.dart';

import 'const.dart';

Future<void> doGet(
  String url,
  String a,
  dynamic body,
  callback(Map<String, dynamic> res),
) async {
  Map<String, dynamic> res;
  try {
    final http.Response response = await http.get(
      Uri.parse(url + a),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': API_KEY,
      },
    );
    if (response.statusCode == 200) {
      res = await json.decode(response.body);
      callback(res);
    } else {
      try {
        if (res != null) {
          callback(
            {
              "rc": res['rc'],
              "message": res['message'],
            },
          );
        } else {
          callback(
            {
              "rc": 400,
              "message": FAILED_TO_CONNECT,
            },
          );
        }
      } catch (e) {
        print("error");
        print(e);
      }
    }
  } catch (e) {
    var err;
    final unconnect = matches(
      e.toString(),
      NETWORK_UNREACHABLE,
    );

    if (unconnect) {
      err = NETWORK_UNREACHABLE;
    } else {
      err = FAILED_TO_CONNECT;
    }
    callback({"status": 400, "message": err.toString()});
    return null;
  }

  return null;
}
