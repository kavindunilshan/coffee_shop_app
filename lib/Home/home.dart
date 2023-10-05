import 'package:coffee_shop_app/Home/brew_list.dart';
import 'package:coffee_shop_app/Home/settings.dart';
import 'package:coffee_shop_app/Model/brew.dart';
import 'package:coffee_shop_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_shop_app/Services/database.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60.0),
          child: SettingsF(),
        );
      });
    }
    return StreamProvider<List<Brew>>.value(
        initialData: [],
      value: DatabaseServices().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          title: Text("Brew Crew"),
          elevation: 0.0,
          backgroundColor: Colors.brown[600],
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.person,
                  color: Color.fromRGBO(243, 238, 238, 1.0),),
                label: Text(
                    "Log Out",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(243, 238, 238, 1.0),
                ),
                ),
            ),
            TextButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(
                Icons.settings,
                color: Color.fromRGBO(243, 238, 238, 1.0),),
              label: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(243, 238, 238, 1.0),
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
              ),
            ),
              child: BrewList(),
          ),
      ),
    );
  }
}
