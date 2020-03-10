import 'package:dio/dio.dart';
import 'package:flutter_base_mvvm_arch/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../base/base.dart';

class HomeProvide extends BaseProvide {
  final GithubRepo _repo;
  String username = '';
  String password = '';
  bool _loading = false;

  String _response = '';
  final String title;

  String get response => _response;

  set response(String response) {
    _response = response;
    notifyListeners();
  }

  bool get loading => _loading;
  double _btnWidth = 295.0;

  double get btnWidth => _btnWidth;

  set btnWidth(double btnWidth) {
    this._btnWidth = btnWidth;
    notifyListeners();
  }

  set loading(bool loading) {
    this._loading = loading;
    notifyListeners();
  }

  HomeProvide(this.title, this._repo);

  Observable login() => _repo
      .login(username, password)
      .doOnData((r) => response = r.toString())
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          response = e.response.data.toString();
        }
      })
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);
}
