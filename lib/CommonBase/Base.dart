import 'package:flutter/material.dart';

class Base extends State{

  bool isLoading = false;

  void setIsLoading(bool loading){
    isLoading = loading;
    updateLayout();
  }

  void updateLayout(){
    setState(() {
    });
  }

  Widget setBody(){
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          setBody(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: (isLoading) ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                    ),
                  ),
                ) : Container(),
              )
            ],
          )
        ],
      ),
      drawer: null,
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
    );
  }
}