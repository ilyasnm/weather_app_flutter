import 'package:flutter/material.dart';
import 'package:pfe/superAdmin.dart';
import 'Data.dart';
import'control.dart';

class Dashboard_Data extends StatefulWidget{

  Dashboard_Data({Key key , this.title}) : super(key : key);
  final String title;



  @override
  Dashboard_DataState  createState() => Dashboard_DataState();
}

class Dashboard_DataState extends State<Dashboard_Data> {

  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Les utilisateurs',
      home: Scaffold(
          appBar: AppBar(
              title:  Text('Mes utilisateurs'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: ()=>Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new MyHomePages(),
                    )
                ),
              )
            ],
          ),

          body: new FutureBuilder<List>(
            future: databaseHelper.getData(),
            builder: (context ,snapshot){
              if(snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ItemList(list: snapshot.data)
                  : new Center(child: new CircularProgressIndicator(),);
            },
          )
      ),
    );
  }


}

// ignore: must_be_immutable
class ItemList extends StatelessWidget {

  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: list==null?0:list.length,
        itemBuilder: (context,i){
          return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new ShowData(list:list , index:i,) ),

              ) ,
              child: new Card(
                child: new ListTile(
                  title: new Text(list[i]['lastname']),
                  leading: new Icon(Icons.account_circle),
                  subtitle: new Text('email : ${list[i]['email']}'),
                ),
              )
              ,
            ),
          );

        }
    );
  }
}
