import 'package:coffee_shop_app/Authenticate/authenticate.dart';
import 'package:coffee_shop_app/Home/brew_tile.dart';
import 'package:coffee_shop_app/Home/home.dart';
import 'package:coffee_shop_app/Model/brew.dart';
import 'package:coffee_shop_app/Model/user.dart';
import 'package:coffee_shop_app/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop_app/Shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsF extends StatefulWidget {
  @override
  _SettingsFState createState() => _SettingsFState();
}

class _SettingsFState extends State<SettingsF> {


  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  String? _currentName;
  String? _currentSugar;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider<User>(
      create: (_) => User(), // Replace User() with your user creation logic
      builder: (context, _) {
        final user = context.watch<User>();
        if (user == null) {
          return Authenticate();
        } else {
          return StreamBuilder<UserData>(
              stream: DatabaseServices(uid: user.uid).userData,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  UserData? userData = snapshot.data;
                  return Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Text(
                          "Update your brew settings",
                          style: TextStyle(fontSize: 24.0),
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          initialValue: userData?.name,
                          cursorHeight: 28.0,
                          decoration: textInputDecoration,
                          validator: (val) => val!.isEmpty ? "please enter a name":null,
                          onChanged: (val) => setState(() => _currentName = val),
                        ),
                        SizedBox(height: 20.0,),
                        DropdownButtonFormField(
                          decoration: textInputDecoration,
                          value: _currentSugar ?? userData?.sugars,
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text(
                                "$sugar sugars",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => _currentSugar = val),
                        ),
                        SizedBox(height: 20.0,),
                        Slider(
                          value: (_currentStrength ?? userData?.strength)!.toDouble(),
                          inactiveColor: Colors.brown[_currentStrength ?? userData?.strength ?? 100],
                          activeColor: Colors.brown[_currentStrength ?? userData?.strength ?? 100],
                          min: 100,
                          max: 900,
                          divisions: 8,
                          onChanged: (val) => setState(() => _currentStrength = val.round())          ,
                        ),
                        SizedBox(height: 20.0,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[800],
                          ),
                          child: Text(
                            "update",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () async {
                            if(_formkey.currentState!.validate()){
                              await DatabaseServices(uid: user.uid)!.updateUserData(
                                _currentSugar ?? userData?.sugars ?? "",
                                _currentName ?? userData?.name ?? "",
                                _currentStrength ?? userData?.strength ?? 100,
                              );
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
                else{
                  return SizedBox.shrink();
                }
              }
          );
        }
      },
    );
    return user;
  }
}
