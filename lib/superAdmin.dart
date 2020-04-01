import 'package:flutter/material.dart';
import 'package:pfe/capteurs.dart';
import 'package:pfe/dashbord_data_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'control.dart';
import 'dashbord_data.dart';
import 'editDataUser.dart';

class MyHomePages extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePages> {
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('hello it a Super admin interface '
            ' Tap on the button'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showButtons,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
  void showButtons() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Dashboard_Data()));
                      },
                      textColor: Colors.white,
                      child: Center(
                        child: Text('gérer les utilisateurs'),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Dashboard_Data_Admin()));
                      },
                      textColor: Colors.white,
                      child: Center(
                        child: Text('gérer les Admins'),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Capteurs()));
                      },
                      textColor: Colors.white,
                      child: Center(
                        child: Text('gérer les capteurs'),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> editDataUser()));
                      },
                      textColor: Colors.white,
                      child: Center(
                        child: Text('Paramétre de compte'),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        _save(null);
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
                      },
                      textColor: Colors.white,
                      child: Center(
                        child: Text('déconnexion'),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }


}
