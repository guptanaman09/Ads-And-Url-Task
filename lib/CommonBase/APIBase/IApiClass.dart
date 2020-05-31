import 'package:adsandurl/CommonBase/APIBase/ResponseListener.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class IApiService{
  Dio _dio;

  postRowData<T>(String url, ResponseListener<T> listener, FormData data);
  get<T>(String url, ResponseListener<T> listner);

  Dio getDio(){
    BaseOptions options = BaseOptions(
      baseUrl: '',
      connectTimeout: 5000,
      receiveTimeout: 8000,
    );
    _dio = Dio(options);
    _dio.options.contentType = Headers.formUrlEncodedContentType;

    return _dio;
  }
}