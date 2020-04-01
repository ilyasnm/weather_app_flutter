import 'package:flutter/material.dart';
import 'control.dart';
import 'addDataCapteur.dart';
import 'dataCapteurs.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Capteurs extends StatefulWidget{

  Capteurs({Key key , this.title}) : super(key : key);
  final String title;

  @override
  CapteursState  createState() => CapteursState();
}

class CapteursState extends State<Capteurs> {

  DatabaseHelper databaseHelper = new DatabaseHelper();



  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Les capteurs',
      home: Scaffold(
          appBar: AppBar(
            title:  Text('Les capteurs'),
          ),
          floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new addDataCapteur(),
                )
            ),
          ),
          body: new FutureBuilder<List>(
            future: databaseHelper.getDataCapteur(),
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
                    builder: (BuildContext context) => new dataCapteur(list:list , index:i,) ),

              ) ,
              child: new Card(
                child: new ListTile(
                  title: new Text(list[i]['name']),
                  leading: new Icon(Icons.settings_input_antenna),
                  subtitle: new Text('mac Adresse : ${list[i]['macAddr']}'),
                ),
              )
              ,
            ),
          );

        }
    );
  }

}
