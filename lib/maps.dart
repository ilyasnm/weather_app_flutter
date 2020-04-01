import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pfe/editDataUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'control.dart';
import 'weather.dart';

class Constants{
  static const String Parametre = 'Pramétre de compte';
  static const String Deconnexion = 'Déconnexion';

  static const List<String> choices = <String>[
   Parametre,
    Deconnexion
  ];
}

class MyApp extends StatefulWidget{


  MyApp({Key key , this.title}) : super(key : key);
  final String title;

  @override
  MyAppState  createState() =>  MyAppState();
}

class  MyAppState extends State< MyApp> {

  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice) {
      if (choice == Constants.Deconnexion) {
        _save(null);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      }
      else if (choice == Constants.Parametre) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => editDataUser()));
      }
    }

    return MaterialApp(
      title: 'Météo Map',
      home: Scaffold(
          appBar: AppBar(
              title:  Text('Météo Map'),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context){
                  return Constants.choices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
            ],
          ),
          body: new FutureBuilder<List>(
            future: databaseHelper.getDataCapteur(),
            builder: (context ,snapshot){
              if(snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new map(list: snapshot.data)
                  : new Center(child: new CircularProgressIndicator(),);
            },
          )
      ),
    );
  }


}

class map extends StatefulWidget {
final List list;
map({this.list});
  @override
  mapState createState() => mapState();
}

class mapState extends State<map> {

  List<Marker> allMarkers = [];
  GoogleMapController _controller;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.list.length; i++) {
      allMarkers.add(Marker(
          markerId: MarkerId(widget.list[i]["name"]),
          draggable: false,
          onTap: () =>Navigator.of(context).push(
            new MaterialPageRoute(
                builder: (BuildContext context) => new weather(list:widget.list , index: i,)
            ),

          ) ,
          infoWindow: InfoWindow(title: widget.list[i]["name"]),
          position: LatLng(double.parse(widget.list[i]["place_x"]),
              double.parse(widget.list[i]["place_y"]))
      ));
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(31.5132022, -9.7630404),
                zoom: 15,),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
        ),
      );
    }
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
  }

_save(String token) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = token;
  prefs.setString(key, value);
}
