import 'dart:convert';

import 'package:adsandurl/Models/HotDataModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  SqliteHelper._();

  static Database _database;
  static final SqliteHelper getInstance = SqliteHelper._();

  final String hotTableName = 'HotData';
  final String newTableName = 'HotData';
  final String columnId = '_id';
  final String nameColumnField = 'name';
  final String titleField = 'title';

  Future<Database> get database async {
    if (_database != null) {
      print('database is not null');
      return _database;
    }
    print('database is null');
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "DemoDataBase.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      print('database created');
      createHotTable(db);
      createNewTable(db);
    });
  }

  createHotTable(Database db) async {
    await db.execute('''create table $hotTableName ( 
      $nameColumnField text not null,
      $titleField text not null)''').whenComplete(() => print('hot table created'));
  }

  createNewTable(Database db) async {
    await db.execute('''create table $newTableName ( 
      $nameColumnField text not null,
      $titleField text not null)''').whenComplete(() => print('hot table created'));
  }

  insertHotData(ChildData data) async {
    Database db = await database;
    db.insert(hotTableName, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  insertNewData(ChildData data) async {
    Database db = await database;
    db.insert(newTableName, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteDataFromHotTable()async{
    Database db = await database;
    db.rawQuery('Delete from ${hotTableName}');
  }

  Future<void> deleteDataFromNewTable()async{
    Database db = await database;
    db.rawQuery('Delete from ${newTableName}');
  }

  Future<HotDataModelData> getHotDataValue() async {
    Database db = await database;
    print('getHotDataValueCalled');
    List<Map<String, dynamic>> list =
        await db.rawQuery('Select * from $hotTableName');
    List<ChildData> data =
        list.map((value) => ChildData.fromJson(value)).toList();
    print('size of the ChildDataList >>> ${data.length}');
    print('data get from hot table is >>> ${jsonEncode(list)}');
    HotDataModelData child = HotDataModelData();
    child.children = List();
    data.forEach((value) {
      Child data = Child();
      data.data = ChildData();
      data.data.name = value.name;
      data.data.title = value.title;
      child.children.add(data);
    });
    return child;
  }

  Future<HotDataModelData> getNewDataValue() async {
    Database db = await database;
    print('getNewDataValue');
    List<Map<String, dynamic>> list =
        await db.rawQuery('Select * from $newTableName');
    List<ChildData> data =
        list.map((value) => ChildData.fromJson(value)).toList();
    print('size of the ChildDataList >>> ${data.length}');
    print('data get from hot table is >>> ${jsonEncode(list)}');
    HotDataModelData child = HotDataModelData();
    child.children = List();
    data.forEach((value) {
      Child data = Child();
      data.data = ChildData();
      data.data.name = value.name;
      data.data.title = value.title;
      child.children.add(data);
    });
    return child;
  }
}
