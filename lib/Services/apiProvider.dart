import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart';

import 'package:path/path.dart';
import 'package:bring2book/Constants/apiPathConstants.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'customException.dart';

class ApiProvider {
  Future<dynamic> get1(String url) async {
    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(ApiNames.API_POST_BASE_URL + url));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getWithHeader(String url, {parameter}) async {
    var responseJson;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString(SharedPrefKey.AUTH_TOKEN);
      print(parameter);

      String queryString = Uri(queryParameters: parameter).query;
      var requestUrl = ApiNames.API_POST_BASE_URL + url + '?' + queryString;

      print('getparmurl$requestUrl');

      final response = await http.get(Uri.parse(requestUrl), headers: {
        'Authorization': 'Bearer $authToken',
      });

      responseJson = _response(response);
      print('getparmurl$responseJson');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post1(
      {@required String path, @required dynamic parameter}) async {
    print(parameter);
    print(path);
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(ApiNames.API_POST_BASE_URL + path),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode(parameter));
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postLogin(
      {@required String path, @required dynamic parameter}) async {
    print(parameter);
    print(path);
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(ApiNames.API_POST_BASE_URL + path),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'refreshtoken': 'MY_KEY'
          },
          body: json.encode(parameter));
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithHeader({@required String path}) async {
    var responseJson;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString(SharedPrefKey.AUTH_TOKEN);
      final response = await http.post(
        Uri.parse(ApiNames.API_POST_BASE_URL + path),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Auth': authToken,
        },
      );
      responseJson = _response(response);
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithHeaderParam(
      {@required String path, @required dynamic parameter}) async {
    var responseJson;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString(SharedPrefKey.AUTH_TOKEN);
      print('auth token is $authToken');
      print('auth token is $parameter');
      final response = await http.post(
          Uri.parse(ApiNames.API_POST_BASE_URL + path),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Auth': authToken
          },
          body: json.encode(parameter));

      responseJson = _response(response);
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String url, String auth) async {
    print("url >>>>>>>>>> " + url);
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(ApiNames.API_POST_BASE_URL + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $auth'
        },
      );
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(
      {@required String path, @required dynamic parameter}) async {
    print(parameter);
    print(ApiNames.API_POST_BASE_URL + path);
    var responseJson;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString(SharedPrefKey.AUTH_TOKEN);
      print(authToken);
      final response =
          await http.post(Uri.parse(ApiNames.API_POST_BASE_URL + path),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $authToken'
              },
              body: json.encode(parameter));
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> multipartpostWithHeader({
    String path,
    Map<String, dynamic> data,
    @required List files,
  }) async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    String authToken = prefss.getString(SharedPrefKey.AUTH_TOKEN);

    try {
      var uri = Uri.parse(ApiNames.API_POST_BASE_URL + path);
      var request = http.MultipartRequest('POST', uri);
      if (data != null) {
        for (MapEntry dataEntry in data.entries) {
          request.fields[dataEntry.key] = dataEntry.value;
          print(dataEntry.key);
          print(dataEntry.value);
        }
      }
      List<MultipartFile> newList = <MultipartFile>[];
      for (int i = 0; i < files.length; i++) {
        File imageFile = File(files[i].toString());
        var stream =
            http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile("file", stream, length,
            filename: basename(imageFile.path));
        newList.add(multipartFile);
      }
      request.files.addAll(newList);

      Map<String, String> headers = {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8'
      };
      request.headers.addAll(headers);

      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        var responseJson = json.decode(respStr);
        return responseJson;
      } else {
        final respStr = await response.stream.bytesToString();
        var responseJson = json.decode(respStr);
        return responseJson;
      }
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> multipartpostAddComment(
      {@required String path,
      @required String comment,
      @required String caseId,
      @required List files,
      @required String auth}) async {
    try {
      SharedPreferences prefss = await SharedPreferences.getInstance();
      String authToken = prefss.getString(SharedPrefKey.AUTH_TOKEN);

      var uri = Uri.parse(ApiNames.API_POST_BASE_URL + path);
      print(uri);
      print(files);

      var request = http.MultipartRequest('POST', uri);
      request.fields['comment'] = comment;
      request.fields['caseId'] = caseId;
      /* for (int i = 0; i < files.length; i++) {
        var file = File(files[i]);
        request.files.add(
          http.MultipartFile(
            'file$i',
            http.ByteStream(DelegatingStream.typed(file.openRead())),
            await file.length(),
            filename: basename(file.path),
          ),
        );*/

      List<MultipartFile> newList = <MultipartFile>[];
      for (int i = 0; i < files.length; i++) {
        File imageFile = File(files[i].toString());
        var stream =
            http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile("file", stream, length,
            filename: basename(imageFile.path));
        newList.add(multipartFile);
      }
      request.files.addAll(newList);

      Map<String, String> headers = {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8'
      };
      request.headers.addAll(headers);

      print(request.files.length);

      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        var responseJson = json.decode(respStr);
        return responseJson;
      } else {
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.reasonPhrase} : ${response.statusCode}');
      }
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        print("responseJson");
        print(responseJson);
        return responseJson;

      default:
        var responseJson = json.decode(response.body);
        print("responseJson");
        print(responseJson);
        return responseJson;
    }
  }

  Future<dynamic> put(
      {@required String path, @required dynamic parameter}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    print(parameter);
    print(path);
    var responseJson;
    try {
      final response =
          await http.put(Uri.parse(ApiNames.API_POST_BASE_URL + path),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $authToken'
              },
              body: json.encode(parameter));
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithoutParams({@required String path}) async {
    var responseJson;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString(SharedPrefKey.AUTH_TOKEN);
      final response = await http.post(
        Uri.parse(ApiNames.API_POST_BASE_URL + path),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
      );
      responseJson = _response(response);
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, String auth) async {
    print(url);
    var responseJson;
    try {
      final response = await http.delete(
        Uri.parse(ApiNames.API_POST_BASE_URL + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $auth'
        },
      );
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      print("No internet ");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
