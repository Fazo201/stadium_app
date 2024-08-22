import "dart:convert";

import "package:http/http.dart" as http;
import "package:http/http.dart";
import "package:http_parser/http_parser.dart";

// import "../../../setup.dart";

class Api {
  // baseUrl
  static const String baseUrl = "e359ad3eac197df4.mokky.dev";

  // APIS
  static String apiGetStadium = "/pitches";

  // headers
  static Map<String, String> headers = <String, String>{
    // "accept": "*/*",
    // "Content-Type": "application/json",
    // "Accept": "application/json",
    // "Authorization": "Bearer $token",
  };

  //methods
  static Future<String?> get(String api, Map<String, String> params) async {
    final Uri url = Uri.https(baseUrl, api, params);
    final http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> post(String api, {Map<String, dynamic>? body, Map<String, dynamic>? param}) async {
    final Uri url = Uri.https(baseUrl, api, param);
    final http.Response response = await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> put(String api, Map<String, dynamic> body, Map<String, dynamic> param) async {
    final Uri url = Uri.https(baseUrl, api, param);
    final http.Response response = await http.put(url, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> multipart(
      String api, String filePath, Map<String, String> body) async {
    final Uri uri = Uri.http(baseUrl, api);
    final http.MultipartRequest request = MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    request.files.add(await MultipartFile.fromPath("file", filePath,
        contentType: MediaType("file", "png")));
    request.fields.addAll(body);
    final StreamedResponse response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.stream.bytesToString();
    } else {
      return response.reasonPhrase;
    }
  }

  static Future<String?> patch(
      String api, Map<String, String> params, Map<String, dynamic> body) async {
    final Uri url = Uri.http(baseUrl, api);
    final http.Response response =
    await http.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> delete(String api, Map<String, String> params) async {
    final Uri url = Uri.http(baseUrl, api, params);
    final http.Response response = await http.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  /// params

  static Map<String, String> emptyParams() => <String, String>{};

  /// body

  static Map<String, dynamic> bodyEmpty() => <String, dynamic>{};

}
