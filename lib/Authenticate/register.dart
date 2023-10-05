import 'package:coffee_shop_app/Services/auth.dart';
import 'package:coffee_shop_app/Shared/constants.dart';
import 'package:coffee_shop_app/Shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function? toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {



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
        title: Text("SignUp Brew Crew"),
        backgroundColor: Colors.brown[600],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggleView!();
            },
            icon: Icon(
                Icons.person,
            color: Colors.white,
            ),
            label: Text(
                "SignIn",
            style: TextStyle(
              color: Colors.white,
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
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = "please supply a valid email";
                        loading = false;
                        });
                      }
                    }
                  },
                child: Text(
                  "Register",
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
