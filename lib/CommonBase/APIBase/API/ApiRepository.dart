
import 'dart:collection';

import 'package:adsandurl/CommonBase/APIBase/ApiService.dart';
import 'package:adsandurl/CommonBase/APIBase/ResponseListener.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'ApiConstants.dart';

class ApiRepository extends ApiService {

 /* deleteOwnerAvailability(ResponseListener listener, FormData data) {
    postFormData(ApiConstants.DELETE_OWNER_AVAILABILITY, data, listener);
  }*/

 getPost(ResponseListener listener){
   get('getPosts', listener);
 }
 getHot(ResponseListener listener){
   get(ApiConstants.HOT_URL, listener);
 }

 getNew(ResponseListener listener){
   get(ApiConstants.NEW_URL, listener);
 }
  
}