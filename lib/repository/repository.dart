import 'dart:convert';

import 'package:flutter_base_mvvm_arch/utils/net_utils.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/constants.dart';
import '../utils/shared_preferences.dart';

class GithubService {
  Observable login() => get("user");
}

class GithubRepo {
  final GithubService _remote;
  final SharePrefUtil _sp;

  GithubRepo(this._remote, this._sp);

  Observable login(String username, String password) {
    _sp.putString(
        KEY_TOKEN, "basic " + base64Encode(utf8.encode('$username:$password')));
    return _remote.login();
  }
}
