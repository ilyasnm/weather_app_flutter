import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'control.dart';
import 'package:http/http.dart' as http;
import 'dashbord_data_admin.dart';
import 'register.dart';
import 'constants.dart';


class ShowDataAdmin extends StatefulWidget{

  List list;
  int index;
  ShowDataAdmin({this.index , this.list}) ;


  @override
  ShowDataAdminState  createState() => ShowDataAdminState();
}

class ShowDataAdminState extends State<ShowDataAdmin> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  var val_text;
  @override
  Widget build(BuildContext context) {
    if(widget.list[widget.index]['role']=='admin'){
      val_text="user";
    }
    else{
      val_text="admin";
    }
    return MaterialApp(
      title: 'Admin',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Admin'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new Dashboard_Data_Admin(),
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
                  "Nom : ${ widget.list[widget.index]['lastname']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new Text(
                  " Prénom : ${widget.list[widget.index]['firstname']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new Text(
                  " email : ${widget.list[widget.index]['email']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new Text(
                  " id : ${widget.list[widget.index]['_id']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new Text(
                  " verfication : ${widget.list[widget.index]['isVerified']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new Text(
                  " role : ${widget.list[widget.index]['role']}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),

              Container(
                child: new FlatButton(
                  onPressed: () async {
                    if(val_text=="admin"){
                      final prefs = await SharedPreferences.getInstance();
                      final key = 'token';
                      final value = prefs.get(key ) ?? 0;
                      String myUrl = "http://vps730710.ovh.net:3080/admin/addAdmin";
                      final response = await http.post(myUrl,
                          headers: {
                            'Authorization' : 'Bearer $value'
                          },
                          body: {
                            "email": "${widget.list[widget.index]['email']}",
                            "num" : "1"
                          });
                      _showDialog("${widget.list[widget.index]['lastname']} est nommé maintenant admin");
                    }
                    else if (val_text=="user"){
                      final prefs = await SharedPreferences.getInstance();
                      final key = 'token';
                      final value = prefs.get(key ) ?? 0;
                      String myUrl = "http://vps730710.ovh.net:3080/admin/addAdmin";
                      final response = await http.post(myUrl,
                          headers: {
                            'Authorization' : 'Bearer $value'
                          },
                          body: {
                            "email": "${widget.list[widget.index]['email']}",
                            "num" : "0"
                          });
                      _showDialog("${widget.list[widget.index]['lastname']} est nommé maintenant user");
                    }
                  },
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  child: Center(
                    child: Text('$val_text'),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }



  void _showDialog(String name){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('Alerte'),
            content:  new Text('$name'),
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
















