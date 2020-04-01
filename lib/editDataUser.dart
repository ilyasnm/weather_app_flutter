import 'package:flutter/material.dart';
import 'package:pfe/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'control.dart';
import 'capteurs.dart';

class editDataUser extends StatefulWidget{

  @override
  editDataUserState  createState() => editDataUserState();
}

class editDataUserState extends State<editDataUser> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  TextEditingController _firstnnameController = new TextEditingController() ;
  TextEditingController _lastnameController =  new TextEditingController()  ;
  TextEditingController _passwordController  =  new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Parametre de compte',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Parametre de compte'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              Container(
                height: 50,
                child: new TextField(
                  controller: _firstnnameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    hintText: 'Modifier votre Nom',
                    icon: new Icon(Icons.account_circle),
                  ),
                ),
              ),

              Container(
                height: 50,
                child: new TextField(
                  controller: _lastnameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                    hintText: 'Mdifier votre prénom',
                    icon: new Icon(Icons.account_circle),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    hintText: 'entrez votre ou votre nouveau mot de passe',
                    icon: new Icon(Icons.lock),
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

              Container(
                child: new RaisedButton(
                  onPressed: (){
                    databaseHelper.editDataUser(_firstnnameController.text.trim(), _lastnameController.text.trim(), _passwordController.text.trim());
                    _showDialog("Modification effectuée");
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
              Container(
                child: new FlatButton(
                  onPressed: (){
                    databaseHelper.deleteDataUser();
                    _showDialog("Suppression effectuée");
                    _save('null');
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new LoginScreen(),
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
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }


  void _showDialog(String txt){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('Alerte'),
            content:  new Text('$txt'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'Close',
                ),

                onPressed: (){
                  Navigator.of(context).pop();
                },

              ),
            ],
          );
        }
    );
  }



}