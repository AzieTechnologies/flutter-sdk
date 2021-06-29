import 'dart:convert';
import 'package:http/http.dart' as http;

class RestClient {
  late String baseURL;
  Map<String, String> headers = Map();
  bool debug = false;

  RestClient(String baseURL, Map<String, String> headers, bool debug) {
    this.baseURL = baseURL;
    this.headers.addAll(headers);
    this.debug = debug;
  }

  Future<Map> get(String path) async {
    Uri uri = Uri.parse(baseURL + path);
    logRequest("Get",uri.toString()+headers.toString(), null);
    var response = await http.get(uri, headers: headers);
    logResponse(response.body);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> object, {Map<String, String> headers = const {} }) async {
    Uri uri = Uri.parse(baseURL + path);
    logRequest("Post",uri.toString(), object);

    Map<String, String> allHeaders = this.headers;
    allHeaders.addAll(headers);

    var response =
        await http.post(uri, headers: allHeaders, body: jsonEncode(object));
    logResponse(response.body);
    return jsonDecode(response.body);
  }

  void logRequest(String method,String url, Map<String, dynamic>? data) {
    if(!debug){
      return;
    }

    print("dev_pay: request method-"+method+" url- "+url);
    if(data != null){
      print("dev_pay: request data - "+data.toString());
    }
  }

  void logResponse(String response){
    if(!debug){
      return;
    }

    if(response.length > 0){
      print("dev_pay: response data - "+response);
    }
  }
}
