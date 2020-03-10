import 'package:dartin/dartin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_mvvm_arch/repository/repository.dart';
import 'package:flutter_base_mvvm_arch/utils/constants.dart';
import 'package:flutter_base_mvvm_arch/utils/shared_preferences.dart';
import 'package:flutter_base_mvvm_arch/viewModel/HomeProvide.dart';

final viewModelModule = Module([
  factory<HomeProvide>(({params}) => HomeProvide(params.get(0), get())),
]);

final repoModule = Module([
  factory<GithubRepo>(({params}) => GithubRepo(get(), get())),
]);

final remoteModule = Module([
  factory<GithubService>(({params}) => GithubService()),
]);

final localModule = Module([
  single<SharePrefUtil>(({params}) => spUtil),
]);

final appModule = [viewModelModule, repoModule, remoteModule, localModule];

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    final token = spUtil.getString(KEY_TOKEN);
    options.headers
        .update("Authorization", (_) => token, ifAbsent: () => token);
    return super.onRequest(options);
  }
}

final dio = Dio()
  ..options = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 30,
      receiveTimeout: 30)
  ..interceptors.add(AuthInterceptor())
  ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

SharePrefUtil spUtil;

init() async {
  spUtil = await SharePrefUtil.getInstance();
  // DartIn start
  startDartIn(appModule);
}
