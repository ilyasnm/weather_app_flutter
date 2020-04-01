import 'package:flutter/material.dart';
import 'control.dart';
import 'capteurs.dart';

class addDataCapteur extends StatefulWidget{

  addDataCapteur({Key key , this.title}) : super(key : key);
  final String title;



  @override
  addDataCapteurState  createState() => addDataCapteurState();
}

class addDataCapteurState extends State<addDataCapteur> {
  DatabaseHelper databaseHelper = new DatabaseHelper();



  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _macAddrController = new TextEditingController();
  final TextEditingController _place_xController = new TextEditingController();
  final TextEditingController _place_yController = new TextEditingController();



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Ajouter Capteur',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Ajouter Capteur'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              Container(
                height: 50,
                child: new TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    hintText: 'Nom de capteur',
                    icon: new Icon(Icons.settings_input_antenna),
                  ),
                ),
              ),

              Container(
                height: 50,
                child: new TextField(
                  controller: _place_xController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'latitude',
                    hintText: 'entrez latitude de capteur',
                    icon: new Icon(Icons.add_location),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new TextField(
                  controller: _place_yController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'longitude',
                    hintText: 'entrez longtitude de capteur',
                    icon: new Icon(Icons.add_location),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new TextField(
                  controller: _macAddrController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Mac adresse',
                    hintText: 'entrez mac adresse de capteur',
                    icon: new Icon(Icons.computer),
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

              Container(
                child: new RaisedButton(
                  onPressed: (){
                    databaseHelper.addDataCapteur(
                        _nameController.text.trim(), _place_xController.text.trim(),_place_yController.text.trim(),_macAddrController.text.trim());
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new Capteurs(),
                        )
                    );
                  },
                  color: Colors.blue,
                  child: new Text(
                    'ajouter',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
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