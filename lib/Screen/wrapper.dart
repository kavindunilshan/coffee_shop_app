import 'package:coffee_shop_app/Authenticate/authenticate.dart';
import 'package:coffee_shop_app/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop_app/Home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<User>(
      create: (_) => User(), // Replace User() with your user creation logic
      builder: (context, _) {
        final user = context.watch<User>();
        if (user == null) {
          return Authenticate();
        } else {
          return Home();
        }
      },
    );
  }
}