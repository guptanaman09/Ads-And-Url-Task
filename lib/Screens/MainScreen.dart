import 'dart:convert';
import 'package:adsandurl/CommonBase/APIBase/API/ApiRepository.dart';
import 'package:adsandurl/CommonBase/APIBase/ResponseListener.dart';
import 'package:adsandurl/CommonBase/Base.dart';
import 'package:adsandurl/DataBase/SqliteHelper.dart';
import 'package:adsandurl/Models/HotDataModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class MainScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends Base with SingleTickerProviderStateMixin{

  TabController tabController;
  int selectedIndex = 1;

  HotDataModel hotModel;
  HotDataModel newModel;

  HotDataModel tempHotModel;
  HotDataModel tempNewModel;
  
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2
    );
    hotModel = HotDataModel();
    hotModel.data = HotDataModelData();
    hotModel.data.children = List();

    tempHotModel = HotDataModel();
    tempHotModel.data = HotDataModelData();
    tempHotModel.data.children = List();

    newModel = HotDataModel();
    newModel.data = HotDataModelData();
    newModel.data.children = List();

    tempNewModel = HotDataModel();
    tempNewModel.data = HotDataModelData();
    tempNewModel.data.children = List();

    tabController.addListener(onTabChange);
    callApi(selectedIndex);
  }

  void onTabChange(){
    print('selected tab number >>> ${tabController.index.toString()}');
    selectedIndex = tabController.index +1;
    callApi(selectedIndex);
  }

  void callApi(int index){
    setIsLoading(true);
    if(index == 1){
      ApiRepository().getHot(new Response(this));
    }
    else{
      ApiRepository().getNew(new Response(this));
    }
  }

  Widget searchBoxLayout(){
    return Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search,size: 28,),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 18),
                onChanged: startSearching,
                decoration: InputDecoration(
                    hintText: 'Search Based on Name',
                    hintStyle: TextStyle(fontSize: 18),
                    border: InputBorder.none
                ),
              ),
            )
          ],
        )
    );
  }

  Widget hotLayout(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(itemBuilder: (BuildContext context, int index){
            return Container(
              margin: EdgeInsets.only(top: 4,bottom: 4),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  title: Text('Name: ' + tempHotModel.data.children[index].data.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  subtitle: Text('Title: ' + tempHotModel.data.children[index].data.title),
                ),
              ),
            );
          },
          itemCount: tempHotModel.data.children.length,),
    )
      ],
    );
  }

  Widget newLayout(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(itemBuilder: (BuildContext context, int index){
            return Container(
              margin: EdgeInsets.only(top: 4,bottom: 4),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
                elevation: 4.0,
                child: ListTile(
                  contentPadding: EdgeInsets.all(4),
                  title: Text('Name: ' + tempNewModel.data.children[index].data.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  subtitle: Text('Title: ' + tempNewModel.data.children[index].data.title),
                ),
              ),
            );
          },
            itemCount: tempNewModel.data.children.length,),
        )
      ],
    );
  }

  @override
  Widget setBody() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          searchBoxLayout(),
          TabBar(
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(color: Colors.blue),
              controller: tabController,
              indicatorWeight: 3.0,
              labelColor: Colors.blue,
              tabs: [
            Tab(
              child: Container(
                child: Center(
                  child: Text('Hot',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
            Tab(
              child: Container(
                child: Center(
                  child: Text('New',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
            )
          ]),
          Expanded(
            child: TabBarView(
              dragStartBehavior: DragStartBehavior.start,
              controller: tabController,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: hotLayout()
                  ),
                  Container(
                      padding: EdgeInsets.all(8),
                      child: newLayout()
                  )
                ]
            ),
          )
        ],
      );
  }

  @override
  void dispose() {
    tabController.removeListener(onTabChange);
    tabController.dispose();
  }

  void storeHotData()async{
    SqliteHelper sqliteHelper = SqliteHelper.getInstance;
    sqliteHelper.deleteDataFromHotTable().then((val)async{
      hotModel.data.children.forEach((model){
        sqliteHelper.insertHotData(model.data);
      });
      HotDataModelData data = await sqliteHelper.getHotDataValue();
      hotModel.data = data;
      tempHotModel.data.children.clear();
      tempHotModel.data.children.addAll(hotModel.data.children);
      print('length of the tempHotModel is >>> ${tempHotModel.data.children.length}');
      updateLayout();
    });
  }

  void storeNewData()async{
    SqliteHelper sqliteHelper = SqliteHelper.getInstance;
    sqliteHelper.deleteDataFromNewTable().then((val)async{
      newModel.data.children.forEach((model){
        sqliteHelper.insertHotData(model.data);
      });
      HotDataModelData data = await sqliteHelper.getNewDataValue();
      newModel.data = data;
      tempNewModel.data.children.clear();
      tempNewModel.data.children.addAll(newModel.data.children);
      print('length of the tempNewModel is >>> ${tempNewModel.data.children.length}');
      updateLayout();
    });
}

  void startSearching(String letter){
    print('word in search >>> ${letter}');
    if(selectedIndex == 1) {
      if (letter.isEmpty) {
          tempHotModel.data.children.clear();
          tempHotModel.data.children.addAll(hotModel.data.children);
      } else {
        tempHotModel.data.children.clear();
        for(int i=0; i<hotModel.data.children.length; i++) {
          if (hotModel.data.children[i].data.name.contains(letter)) {
            tempHotModel.data.children.add(hotModel.data.children[i]);
          }
        }
      }
      updateLayout();
    }else{
      if (letter.isEmpty) {
        tempNewModel.data.children.clear();
        tempNewModel.data.children.addAll(newModel.data.children);
      } else {
        tempNewModel.data.children.clear();
        for(int i=0; i<newModel.data.children.length; i++){
          if(newModel.data.children[i].data.name.contains(letter)){
            tempNewModel.data.children.add(newModel.data.children[i]);
          }
        }
      }
      updateLayout();
    }
  }

}

class Response extends ResponseListener{
  MainScreenState context;
  Response(this.context);

  @override
  updateIfLive(t) {
    context.setIsLoading(false);
    if(context.selectedIndex == 1) {
      print('response of Hot is >>> ${jsonEncode(t)}');
      HotDataModel model = HotDataModel.fromJson(t);
      context.hotModel = model;
      print('size of the list is >>> ${model.data.children.length}');
      context.storeHotData();
    }
    else{
      print('response of New is >>> ${jsonEncode(t)}');
      HotDataModel model = HotDataModel.fromJson(t);
      context.newModel = model;
      context.storeNewData();
    }
  }

}