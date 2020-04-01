import 'package:pfe/dataCapteurs.dart';

import 'control.dart';
import 'package:flutter/material.dart';
import 'maps.dart';

class weather extends StatefulWidget{
  List list;
  int index;
   weather({this.list, this.index});

   @override
  weatherState createState() => weatherState();
}

class weatherState extends State<weather>{

  DatabaseHelper databaseHelper = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //  backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: new Text("Météo") ,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.map),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new MyApp(),
                  )
              ),
            )
          ],
        ),
          body: new FutureBuilder<Map>(
            future: databaseHelper.getDataWeather(widget.list[widget.index]['macAddr']),
            builder: (context ,snapshot){
              if(snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new temp(list: snapshot.data)
                  : new Center(child: new CircularProgressIndicator(),);
            },
          )
      ),
    );
  }

}
class temp extends StatefulWidget {
  final Map list;
  temp({this.list});
  @override
  tempState createState() => tempState();
}
class tempState extends State<temp>{
  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: Colors.indigoAccent ,
          body: ListView(
            children: <Widget>[
              Padding(
              padding: const EdgeInsets.only(top: 100.0,left: 12.0,right: 12.0,bottom: 12.0),
              child: Center(
                child:new Text(
                  "Température ",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ) ,
              ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                 child: Center(
                  child: new Text(
                      "${ widget.list['temp']}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                 ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0,left: 12.0,right: 12.0,bottom: 12.0),
                child: Center(
                  child:new Text(
                    "Humidité ",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ) ,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Center(
                  child: new Text(
                    "${ widget.list['humidite']}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
    ],
    ),
      );
  }
}
