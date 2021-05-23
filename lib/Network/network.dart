import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/log.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/BasicUtilities/toast.dart';
import 'package:shopper/src/Registration/ui/welcome_page.dart';
import 'package:http/http.dart' as http;

class NetworkCall{

  Future<dynamic> call(String data, BuildContext context, String url,{bool withToken= true}) async {
    SharedPreferences prefs = locator<SharedPreferences>();
    final JsonDecoder _decoder = new JsonDecoder();
    String token;
    var headers;
    if (withToken) {
      token = prefs.getString(Strings.token);
      headers = {
        "Content-Type": 'application/json',
        "Authorization": 'Token' + " " + token
      };
      Log.console('Token $token');
      print(url);
    } else {
      headers = {
        "Content-Type": 'application/json',
      };
    }

    return _post(context, url, body: data, headers: headers)
        .then((dynamic res) {
      return _decoder.convert(res.toString());
    });
  }
  Future<dynamic> _post(BuildContext context, String url,
      {Map headers, body, encoding}) async {
    Log.console('url-$url');
    // SharedPreferences prefs = locator<SharedPreferences>();
    final JsonDecoder _decoder = new JsonDecoder();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Log.console('requestBody-$body');
        return http
            .post(Uri.parse(url), body: body, headers: headers, encoding: encoding)
            .then((http.Response response) async {
          final String res = response.body;

          Log.console('res-$res');
          final int statusCode = response.statusCode;
          final body = jsonDecode(response.body);
          String stCode=  body["statusCode"];
          if (body["detail"] != null && body["detail"] == "Invalid token.") {
            // prefs = await SharedPreferences.getInstance();
            ToastAndSnackbar.showToast(
                ShopperLocalizations(context).localization.session_expire,
                ShopperColor.information);
            // prefs.clear();

            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return WelcomePage();
                  }), ModalRoute.withName('/'));
            });
          }
          else if (stCode!=null && stCode.startsWith("F"))
          { throw new Exception("Something is wrong !! please try later");}
          else if (statusCode < 200 || json == null) {

            throw new Exception(_decoder.convert(res)['error']['message']);
          } else if (statusCode >= 400 || json == null) {
            throw new Exception("Something Went Wrong!!");
          }
          return res;
        }).catchError((onError) {
          Log.console("Error"+onError.toString());
          if (onError.toString().toLowerCase().contains("timeout"))
            throw new Exception("Server timeout");
          else
            throw new Exception("Something Went Wrong!!");
        });
      }
    } on SocketException catch (_) {
      ToastAndSnackbar.showToast(
          ShopperLocalizations(context).localization.no_internet,
          ShopperColor.information);
      throw new Exception(
          ShopperLocalizations(context).localization.no_internet);
    }
  }
}