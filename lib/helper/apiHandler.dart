import 'package:dio/dio.dart';
import '../helper/sharedPref.dart';
import '../model/apiResponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiHandler {
  SharedPref shared = new SharedPref();

  ///To fetch Data from the [api]
  ///with [Token]
  Future<ApiResponse> getToken({String url}) async {
    ApiResponse apiResponse;
    Dio dio = new Dio();
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      maxWidth: 90,
    ));
    final extData = await shared.read('userData');
    var token = extData['token'];

    try {
      var response = await dio.get(
        url,
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        apiResponse = new ApiResponse(
          code: res['code'],
          msg: res['message'],
          object: response.data,
        );
      } else {
        apiResponse = _resException(response);
      }
    } on DioError catch (e) {
      return _dioException(e);
    } on FormatException {
      print(Exception);
      // throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      print(Exception);
      // throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      print(Exception);
      // throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  ///To Send Data to the [api]
  ///with [Token]
  Future<ApiResponse> postToken({
    String url,
    Map<dynamic, dynamic> body,
  }) async {
    ApiResponse apiResponse;
    final extData = await shared.read('userData');
    var token = extData['token'];
    Dio dio = new Dio();
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      maxWidth: 90,
    ));
    try {
      var response = await dio.post(
        url,
        data: body,
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        apiResponse = new ApiResponse(
          code: res['code'],
          msg: res['message'],
          object: response.data,
        );
      } else {
        apiResponse = _resException(response);
      }
    } on DioError catch (e) {
      return _dioException(e);
    } on FormatException {
      print(Exception);
      // throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      print(Exception);
      // throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      print(Exception);
      // throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  ///To Update Data On the [api]
  ///with [Token]
  Future<ApiResponse> putToken({
    String url,
    Map<dynamic, dynamic> body,
  }) async {
    ApiResponse apiResponse;
    Dio dio = new Dio();
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      maxWidth: 90,
    ));
    try {
      var response = await dio.put(
        url,
        data: body,
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        apiResponse = new ApiResponse(
          code: res['code'],
          msg: res['message'],
          object: response.data,
        );
      } else {
        apiResponse = _resException(response);
      }
    } on DioError catch (e) {
      return _dioException(e);
    } on FormatException {
      print(Exception);
      // throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      print(Exception);
      // throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      print(Exception);
      // throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  ///To Delete Data From the [api]
  ///with [Token]
  Future<ApiResponse> deleteToken({String url}) async {
    ApiResponse apiResponse;
    Dio dio = new Dio();
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      maxWidth: 90,
    ));
    final extData = await shared.read('userData');
    var token = extData['token'];
    try {
      var response = await dio.delete(
        url,
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        apiResponse = new ApiResponse(
          code: res['code'],
          msg: res['message'],
          object: response.data,
        );
      } else {
        apiResponse = _resException(response);
      }
    } on DioError catch (e) {
      return _dioException(e);
    } on FormatException {
      print(Exception);
      // throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      print(Exception);
      // throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      print(Exception);
      // throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  ///To fetch Data from the [api]
  ///without [Token]
  Future<ApiResponse> get({String url}) async {
    ApiResponse apiResponse;
    Dio dio = new Dio();
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      maxWidth: 90,
    ));
    try {
      var response = await dio.get(
        url,
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        apiResponse = new ApiResponse(
          code: res['code'],
          msg: res['message'],
          object: response.data,
        );
      } else {
        apiResponse = _resException(response);
      }
    } on DioError catch (e) {
      return _dioException(e);
    } on FormatException {
      print(Exception);
      // throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      print(Exception);
      // throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      print(Exception);
      // throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  ///To Send Data to the [api]
  ///without [Token]
  Future<ApiResponse> post({
    String url,
    Map<dynamic, dynamic> body,
  }) async {
    ApiResponse apiResponse;
    Dio dio = new Dio();
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      maxWidth: 90,
    ));
    try {
      var response = await dio.post(
        url,
        data: body,
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        apiResponse = new ApiResponse(
          code: res['code'],
          msg: res['message'],
          object: response.data,
        );
      } else {
        apiResponse = _resException(response);
      }
    } on DioError catch (e) {
      print(e);
      return _dioException(e);
    } on FormatException {
      print(Exception);
      print(Exception);
      // // throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      print(Exception);
      print(Exception);
      // // throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      print(Exception);
      print(Exception);
      // // throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  ///To Update Data On the [api]
  ///with [Token]
  Future<ApiResponse> put({
    String url,
    Map<dynamic, dynamic> body,
  }) async {
    ApiResponse apiResponse;
    final extData = await shared.read('userData');
    var token = extData['token'];
    Dio dio = new Dio();
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      maxWidth: 90,
    ));
    try {
      var response = await dio.put(
        url,
        data: body,
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        apiResponse = new ApiResponse(
          code: res['code'],
          msg: res['message'],
          object: response.data,
        );
      } else {
        apiResponse = _resException(response);
      }
    } on DioError catch (e) {
      return _dioException(e);
    } on FormatException {
      print(Exception);
      // throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      print(Exception);
      // throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      print(Exception);
      // throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  ///To Delete Data From the [api]
  ///without [Token]
  Future<ApiResponse> delete({String url}) async {
    ApiResponse apiResponse;
    Dio dio = new Dio();
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      maxWidth: 90,
    ));
    try {
      var response = await dio.delete(
        url,
        options: Options(
          sendTimeout: 5000,
          receiveTimeout: 3000,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        apiResponse = new ApiResponse(
          code: res['code'],
          msg: res['message'],
          object: response.data,
        );
      } else {
        apiResponse = _resException(response);
      }
    } on DioError catch (e) {
      return _dioException(e);
    } on FormatException {
      print(Exception);
      // throw Exception('Format Exception ');
    } on IntegerDivisionByZeroException {
      print(Exception);
      // throw Exception('IntegerDivisionByZeroException ');
    } catch (Exception) {
      print(Exception);
      // throw Exception(' Unknown Exception ');
    } finally {
      dio.close();
    }
    return apiResponse;
  }

  ///To Handel Dio exception
  ApiResponse _dioException(DioError exception) {
    print("*************\tSTART DioError exception\t*************\n");
    print("\n###\t\nError: ${exception.error}\n");
    print("Path: ${exception.requestOptions.path}\n");
    print("Request data: ${exception.requestOptions.data}\n");
    print("Headers: ${exception. requestOptions.headers}\n###\n");
    print("\n*************\tSTART DioError exception\t*************");
    switch (exception.type) {
      case DioErrorType.connectTimeout:
        return ApiResponse(code: exception.type.index, msg: "CONNECT_TIMEOUT");
        break;
      case DioErrorType.sendTimeout:
        return ApiResponse(code: exception.type.index, msg: "SEND_TIMEOUT");
        break;
      case DioErrorType.receiveTimeout:
        return ApiResponse(code: exception.type.index, msg: "RECEIVE_TIMEOUT");
        break;
      case DioErrorType.response:
        return ApiResponse(code: exception.type.index, msg: "RESPONSE");
        break;
      case DioErrorType.cancel:
        return ApiResponse(code: exception.type.index, msg: "CANCEL");
        break;
      case DioErrorType.other:
        return ApiResponse(code: exception.type.index, msg: "DEFAULT");
        break;
      default:
        return ApiResponse(code: exception.type.index, msg: "DEFAULT");
        break;
    }
  }

  ///To handel Response exception
  ApiResponse _resException(Response response) {
    var apiResponse = new ApiResponse();
    if (response.statusCode == 200) {
      apiResponse = new ApiResponse(
        code: 1,
        object: response.data,
      );
    } else if (response.statusCode > 299 || response.statusCode < 400) {
      apiResponse = new ApiResponse(
        code: 3,
        msg: "Could not connect to server",
      );
    } else if (response.statusCode > 399 || response.statusCode < 500) {
      apiResponse = new ApiResponse(
        code: 4,
        msg: "Sorry Bad Request, Pleas Try Again Later",
      );
    } else if (response.statusCode > 499) {
      apiResponse = new ApiResponse(
        code: 5,
        msg: "Server Error",
      );
    }
    return apiResponse;
  }
}
