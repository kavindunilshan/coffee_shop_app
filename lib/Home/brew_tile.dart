import 'package:coffee_shop_app/Model/brew.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

  // Starting from Dart 2.12, null-safety is introduced, which means that variables can't be null unless you explicitly specify them as nullable.
  final Brew? brew;

  BrewTile({this.brew});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        color: Color.fromARGB(255, 218, 207, 207),
        borderOnForeground: true,
        elevation: 1,
        margin: EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 32.0,
            backgroundColor: Colors.brown[brew?.strength ?? 100],
            backgroundImage: AssetImage("assets/coffee_icon.png"),
          ),
          title: Text(
            brew?.name ?? '',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            //fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          ),
          subtitle: Text("Takes ${brew?.sugars ?? 1} sugars"),
        ),
      ),
    );
  }
}
