import 'package:dio/dio.dart';


class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // SharePreferenceUtils.getShareData(Constant.username).then((value) => {
    //   options.headers.addAll({"authorization":value??""}),
    // });
    // LogUtils.logInfo('CustomInterceptors onRequest PATH:=[${options.path}]\nHEADERS:=[${options.headers}]\nREQUEST:=[${options.method}]');
    return super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // LogUtils.logInfo('CustomInterceptors onResponse PATH:=[${response.requestOptions.path}]\n=> statusCode:=[${response.statusCode}]\n=>data:=[${response.data}]');
    super.onResponse(response, handler);
  }
  @override
  // Future onError(DioError err, ErrorInterceptorHandler handler) {
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // LogUtils.logInfo('CustomInterceptors ERROR[${err.response?.statusCode}]\nPATH: ${err.requestOptions.path}');
    return handler.next(err);
  }
}
