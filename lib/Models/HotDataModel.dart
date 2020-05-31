// To parse this JSON data, do
//
//     final hotDataModel = hotDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:adsandurl/CommonBase/APIBase/API/ApiRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

HotDataModel hotDataModelFromJson(String str) =>
    HotDataModel.fromJson(json.decode(str));

String hotDataModelToJson(HotDataModel data) => json.encode(data.toJson());

class HotDataModel {
  String kind;
  HotDataModelData data;

  HotDataModel({
    this.kind,
    this.data,
  });

  factory HotDataModel.fromJson(Map<String, dynamic> json) => HotDataModel(
        kind: json["kind"],
        data: HotDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "data": data.toJson(),
      };
}

class HotDataModelData {
  List<Child> children;
  HotDataModelData({
    this.children,
  });

  factory HotDataModelData.fromJson(Map<String, dynamic> json) =>
      HotDataModelData(
        children:
            List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class Child {
  ChildData data;

  Child({
    this.data,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        data: ChildData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class ChildData {
  String title;
  String name;

  ChildData({
    this.title,
    this.name,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
        title: json["title"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "name": name,
      };
}
