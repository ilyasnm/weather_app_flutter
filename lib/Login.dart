
/*class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('ntjnrt'),),
      body: Container(

        child: ListView(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: "Email",
                    icon: Icon(Icons.mail)
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Mot de passe",
                    icon: Icon(Icons.lock),

                ),
              ),
        Center(
          child: RaisedButton(

            onPressed: (){print("ahmed");},
            color: Colors.blue,
            textColor: Colors.white,
            child: Text("Sing in"),
          ),
        )
            ]
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe/control.dart';
import 'package:pfe/register.dart';
import 'constants.dart';
import 'admin.dart';
import 'dashbord.dart';
import 'maps.dart';
import 'superAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

DatabaseHelper databaseHelper = new DatabaseHelper();

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  var role;

  onPressed(){
    setState(() {
      if(_emailController.text.trim().toLowerCase().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty ){
        databaseHelper.loginData(_emailController.text.trim(),

            _passwordController.text).whenComplete((){

              if(databaseHelper.dat==true){
                _showDialog("Your account has not been verified");
              }

       else if(databaseHelper.status==true){

         if(databaseHelper.statu==true){
           role = "user";
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new MyApp()));
         }
         else if(databaseHelper.sA==true){
           role = "sup";
           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new MyHomePages()));

         }
         else if(databaseHelper.data==true){
           role ="admin";
           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new HomePages()));
         }
       }else {
         _showDialog('login failed');
       }
        });

      }else{
        _showDialog('remplire tous les champs');
      }
    });
  }
  read() async {
    final pref = await SharedPreferences.getInstance();
    final prefs = await SharedPreferences.getInstance();
    final keys = 'role';
    final key = 'token';
    final value = prefs.get(key ) ?? null;
    final values = prefs.get(keys ) ?? 0;
    if(value != null){
      if(values=="user"){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new MyApp()));
      }
      else if(values=="supperAdmin"){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new MyHomePages()));

      }
      else if(values=="admin"){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new HomePages()));
      }
    }
  }
  @override
  initState(){
    read();
  }

  void _showDialog(String name){
    showDialog(
        context:context ,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text('alerte'),
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Entrer votre Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mot de passe',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Entrez votre mot de passe',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Se connecter',
          style: TextStyle(
            color: Color(0xFF527DAA),

            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }




  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> RegisterScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'vous n\'avez pas un compte? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Inscription',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Se conneter',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildLoginBtn(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
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
}
