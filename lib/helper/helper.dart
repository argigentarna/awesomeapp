import 'dart:convert';

import 'package:awesomeapp/models/response.dart';
import 'package:http/http.dart' as http;
import 'package:string_validator/string_validator.dart';

import 'const.dart';

Future<void> doGet(
  String url,
  String a,
  callback(Map<String, dynamic> res),
) async {
  // Map<String, dynamic> res;
  try {
    final http.Response response = await http.get(
      Uri.parse(url + a),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': API_KEY,
      },
    );
    Response res = Response(
      rc: response.statusCode,
      data: json.decode(response.body),
    );

    callback(res.toJson());
  } catch (e) {
    print("THERE IS ERROR");
    print(e.toString());
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
