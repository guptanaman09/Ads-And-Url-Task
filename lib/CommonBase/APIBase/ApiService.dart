
import 'package:adsandurl/CommonBase/APIBase/API/ApiConstants.dart';
import 'package:adsandurl/CommonBase/APIBase/IApiClass.dart';
import 'package:adsandurl/CommonBase/APIBase/ResponseListener.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart';

class ApiService extends IApiService{

  @override
  get<T>(String url, ResponseListener<T> listner) async{
    Dio dio = getDio();
    Response<T> response = await dio.get<T>(url);
    if(response.data != null && response.statusCode == 200){
      listner.updateIfLive(response.data);
    }
  }

  @override
  postRowData<T>(String url, ResponseListener<T> listener, FormData data)async{
    Dio dio = getDio();
    Response<T> response = await dio.post<T>(url,data: data);
    if(response.data != null && response.statusCode == 200){
      listener.updateIfLive(response.data);
    }
  }
}