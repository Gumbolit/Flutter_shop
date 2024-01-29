import 'dart:async';

import 'package:flutter/material.dart';

import '../../custom_class/ClassUserInf.dart';
import '../../custom_wiget/custom_boyum_navigator.dart';

class User_profile_screen extends StatelessWidget {
  const User_profile_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
        body:UserProfileRegistration(),
        bottomNavigationBar: CustomBotumBar(Index: 4));
  }
}


class UserProfileRegistration extends StatefulWidget {
  const UserProfileRegistration({super.key});

  @override
  State<UserProfileRegistration> createState() => _UserProfileRegistrationState();
}

class _UserProfileRegistrationState extends State<UserProfileRegistration> {

  UserInf registration = UserInf();
  //print("на странице профиля в initState");
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      registration.initialize();
      setState(() {
        _initialized = true;
      });
    });
  }

  TextEditingController _textLogin = TextEditingController();
  TextEditingController _textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if (!_initialized) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator(),]); // Return an empty container if not initialized yet
    }else{
      if (registration.registration.isEmpty){
        print("на странице профиля registration isEmpty"+registration.registration.toString());
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _textLogin,
                  decoration: InputDecoration(labelText: 'Login'),
                ),
                TextFormField(
                  controller: _textPassword,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    backgroundColor: Colors.black,
                    textStyle: TextStyle(fontSize: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),

                      //side: BorderSide(width: 50, color: Colors.black),
                    ),
                    minimumSize: Size(380, 40),
                  ),
                  onPressed: () async {
                    await registration.addRegistration(_textLogin.text.toString(), _textPassword.text.toString());
                    setState(() {


                    });
                  },
                  child: Text('Register an account',style: TextStyle(
                      color: Colors
                          .white)),

                ),
                SizedBox(height: 16.0),

              ],
            ),
          ),

        );

      }else{
        print("на странице профиля registration is NOT Empty"+registration.registration.toString());
        _textLogin.text=registration.registration[0];
        _textPassword.text=registration.registration[1];
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _textLogin,
                  decoration: InputDecoration(labelText: 'Login'),
                ),
                TextFormField(
                  controller: _textPassword,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    backgroundColor: Colors.black,
                    textStyle: TextStyle(fontSize: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),

                      //side: BorderSide(width: 50, color: Colors.black),
                    ),
                    minimumSize: Size(380, 40),
                  ),
                  onPressed: () async {
                    await registration.leaveRegistration();
                    await registration.deleteAllFavorites();
                    setState(() {
                      _textLogin.text= '';
                      _textPassword.text= '';



                    });
                  },
                  child: Text('Leave your account',style: TextStyle(
                      color: Colors
                          .white)),
                ),
                SizedBox(height: 16.0),

              ],
            ),
          ),
        );

      };

    }



  }

}
