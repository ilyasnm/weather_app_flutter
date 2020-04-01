import 'dart:convert';
import 'dart:async';
import 'package:pfe/maps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class DatabaseHelper{

  String serverUrl = "http://vps730710.ovh.net:3080";
  bool status ;
  var token ;
  String role;
  bool statu;
  bool sA;
  bool data;
  bool dat;
  bool data1;


  loginData(String email , String password) async{
    var login ={
      "email": "$email",
      "password" : "$password"
    };
    String myUrl = "$serverUrl/user/login";
    final response = await  http.post(myUrl,
        body: login);

    status = response.body.contains("token");
    statu = response.body.contains("user");
    data = response.body.contains("admin");
    sA = response.body.contains("supperAdmin");
    dat = response.body.contains("Your account has not been verified");
   var js= json.decode(response.body);
    if(status==true){
      _save(js["token"]);
      save(js["role"]);
    }
  }

  registerData(String lastname ,String firstname ,String email , String password , String pass) async {
    var registre = {
      "lastname": "$lastname",
      "firstname": "$firstname",
      "email": "$email",
      "password": "$password",
      "password2": "$pass"
    };
    String myUrl = "$serverUrl/user/signup";
    final response = await http.post(myUrl, body: registre);
    //var js= json.encode(response.body);
    dat = response.body.contains('Mail Existe');
    data = response.body.contains('Passwords do not match');
    data1 = response.body.contains('Password must be at least 6 characters');
    statu = response.body.contains('Please enter all fields');
    var js = json.decode(response.body);
  }
   save(String role) async{
    final pref =await SharedPreferences.getInstance();
    final keys ="role";
    final values = role;
    pref.setString(keys, values);
   }
    _save(String token) async {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = token;
      prefs.setString(key, value);
    }
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
  }

  Future<List> getData() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/user/allDataUser";
    http.Response response = await http.get(myUrl,
        headers: {
          'Authorization' : 'Bearer $value'
        });
    return json.decode(response.body);
  }
  Future<List> getDataAdmin() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/admin/allDataAdmin";
    http.Response response = await http.get(myUrl,
        headers: {
          'Authorization' : 'Bearer $value'
        });
    return json.decode(response.body);
  }

  Future<List> getDataCapteur() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/capteur/allDataCapteur";
    http.Response response = await http.get(myUrl,
        headers: {
          'Authorization' : 'Bearer $value'
        });
    return json.decode(response.body);
  }
  void addDataCapteur(String name , String place_x , String place_y, String macAddr ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/capteur/addCapteur";
    http.post(myUrl,
        headers: {
          'Authorization' : 'Bearer $value'
        },
        body: {
          "name": "$name",
          "place_x" : "$place_x",
          "place_y" : "$place_y",
          "macAddr" : "$macAddr"
        });
  }
  void editDataCapteur(String name , String placex, String placey, String macAddr) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/capteur/updateCapteur";
    http.post(myUrl,
        headers: {
          'Authorization' : 'Bearer $value'
        },
        body: (
            {
          "name": "$name",
          "place_x" : "$placex",
          "place_y" : "$placey",
          "macAddr" : "$macAddr"
          }
        )
    );
    }
  Future<Map> getDataWeather(String macAddr) async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/capteur/temp&humi/$macAddr/lastData";
    http.Response response = await http.get(myUrl,
        headers: {
          'Authorization' : 'Bearer $value'
        });

    return json.decode(response.body);

  }
  void deleteDataCapteur(String macAddr ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/capteur/deleteCapteur/$macAddr";
    http.delete(myUrl,
        headers: {
          'Authorization' : 'Bearer $value'
        },

        );
  }

  void editDataUser(String firstname , String lastname, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/user/update";
    http.put(myUrl,
        headers: {
          'Authorization' : 'Bearer $value'
        },
        body: (
            {
              "firstname": "$firstname",
              "lastname" : "$lastname",
              "password" : "$password"
            }
        )
    );
  }
  void deleteDataUser() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/user/delete";
    http.delete(myUrl,
        headers: {
          'Authorization' : 'Bearer $value'
        },
    );
  }
}








