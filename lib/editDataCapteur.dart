import 'package:flutter/material.dart';
import 'control.dart';
import 'capteurs.dart';

class editDataCapteur extends StatefulWidget{

  List list;
  int index;
  editDataCapteur({this.index , this.list}) ;


  @override
  editDataCapteurState  createState() => editDataCapteurState();
}

class editDataCapteurState extends State<editDataCapteur> {
  DatabaseHelper databaseHelper = new DatabaseHelper();


  TextEditingController _nameController  ;
  TextEditingController _place_xController  ;
  TextEditingController _place_yController  ;

  @override
  void initState(){
    _nameController = new TextEditingController(text: widget.list[widget.index]['name']);
    _place_xController = new TextEditingController(text: widget.list[widget.index]['place_x']);
    _place_yController = new TextEditingController(text: widget.list[widget.index]['place_y']);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Modifier Capteur',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Modifier Capteur'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              Container(
                height: 50,
                child: new TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
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
                    hintText: 'entrez longitude de capteur',
                    icon: new Icon(Icons.add_location),
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

              Container(
                child: new RaisedButton(
                  onPressed: (){
                    databaseHelper.editDataCapteur(_nameController.text.trim(), _place_xController.text.trim(), _place_yController.text.trim(),
                        widget.list[widget.index]['macAddr']);
                    _showDialog();
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Modifier',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),




            ],
          ),
        ),
      ),
    );
  }



  void _showDialog(){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('Alerte'),
            content:  new Text('modification effectuée'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'Close',
                ),

                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new Capteurs()));
                },

              ),
            ],
          );
        }
    );
  }



}