import 'package:flutter/material.dart';
import 'package:pfe/dashbord.dart';
import 'package:pfe/editDataUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'capteurs.dart';

class HomePages extends StatefulWidget{
  @override
  _MyHomePage createState() => _MyHomePage();
}


class _MyHomePage extends State<HomePages> {
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
        child: Text('hello it a admin interface '
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Dashboard()));
                      },
                   textColor: Colors.white,
                     child: Center(
                       child: Text('afficher toutes les utilisateurs'),
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
