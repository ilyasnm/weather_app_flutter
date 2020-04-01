import 'package:flutter/material.dart';
import 'control.dart';
import 'capteurs.dart';
import 'editDataCapteur.dart';



class dataCapteur extends StatefulWidget{

  List list;
  int index;
  dataCapteur({this.index , this.list}) ;


  @override
  dataCapteurState  createState() => dataCapteurState();
}

class dataCapteurState extends State<dataCapteur> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Capteur',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Capteur'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new Capteurs(),
                  )
              ),
            )
          ],
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[

              Container(
                height: 50,
                child: new Text(
                  "Name : ${ widget.list[widget.index]['name']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),
              Container(
                height: 50,
                child: new Text(
                  " latitude : ${widget.list[widget.index]['place_x']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

              Container(
                height: 50,
                child: new Text(
                  " longitude : ${widget.list[widget.index]['place_y']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                height: 50,
                child: new Text(
                  " Mac Adresse  : ${widget.list[widget.index]['macAddr']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

                  Container(
                    child: new FlatButton(
                      onPressed: ()=>Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new editDataCapteur(list:widget.list , index:widget.index),
                          )
                      ) ,
                      color: Colors.green,
                      child: new Text(
                        'Modifier',
                        style: new TextStyle(
                          color: Colors.white,
                        ),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),

                  ),

                  Container(
                    child: new FlatButton(
                      onPressed: (){
                        databaseHelper.deleteDataCapteur(widget.list[widget.index]['macAddr']);
                        Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new Capteurs(),
                            )
                        );
                      },
                      color: Colors.red,
                      child: new Text(
                        'supprimer',
                        style: new TextStyle(
                          color: Colors.white,
                        ),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

}
