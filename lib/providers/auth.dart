import 'dart:async';
import 'dart:convert';

import 'package:Shop_App/models/HttpException.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

bool get isAuth {}

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  var _authTime;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyBdoEblRjgjusn6ydCdBIEIyckvEFGvE-Q';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      autoLogout();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }

  void logout() {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTime != null) {
      _authTime.cancel();
      _authTime = null;
    }
    notifyListeners();
  }

  void autoLogout() {
    if (_authTime != null) {
      _authTime.cancel();
    }
    final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTime = Timer(Duration(seconds: timeToExpire), logout);
  }
}
