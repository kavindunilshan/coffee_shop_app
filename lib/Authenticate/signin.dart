import 'package:coffee_shop_app/Shared/constants.dart';
import 'package:coffee_shop_app/Shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop_app/Services/auth.dart';

class SignIn extends StatefulWidget {

  final Function? toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {



  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("SignIn Brew Crew"),
        backgroundColor: Colors.brown[800],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[800],
              ),
              onPressed: () {
                widget.toggleView!();
              },
              icon: Icon(Icons.person,color: Color.fromRGBO(255, 255, 255, 1.0),),
              label: Text(
                  "Register",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1.0),
                fontSize: 16.0,
              ),
              ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/coffee_bg.png"),
              fit: BoxFit.cover,
            )
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val!.isEmpty ? "Enter email":null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val) => val!.length < 6 ? "Enter password 6+ chars long":null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 24.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 54, 115, 1.0),
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          loading = false;
                          error = "could not sign in with those credentials";
                        });
                      }
                    }
                  },
                child: Text(
                    "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                  ),
              SizedBox(height: 16.0,),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
