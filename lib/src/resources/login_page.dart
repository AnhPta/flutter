import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/blocs/login_bloc.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc = new LoginBloc();

  bool _showPass = true;

  // get value input
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(), // set width-height full screen
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.brown[100],
                ),
                width: 70,
                height: 70,
                padding: EdgeInsets.all(10),
                child: FlutterLogo(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Text(
                'Hello\nWellcom Back',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            StreamBuilder(
              stream: bloc.userStream,
              builder: (context, snapshot) => TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Username',
                    labelStyle: TextStyle(fontSize: 18),
                    hintText: 'Nhập username',
                    errorText: snapshot.hasError ? snapshot.error : null),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  StreamBuilder(
                    stream: bloc.passStream,
                    builder: (context, snapshot) => TextField(
                      controller: _passwordController,
                      obscureText: _showPass,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 20),
                          errorText: snapshot.hasError ? snapshot.error : null),
                    ),
                  ),
                  GestureDetector(
                    onTap: showPassword,
                    child: Text( _showPass ? 'SHOW PASSWORD' : 'HIDE PASSWORD',
                        style: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: SizedBox(
                width: double.infinity, // set width full screen
                height: 40,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: handleClick,
                  child: const Text('Login',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('NEW USER? '),
                      Text('SIGN UP',
                          style: TextStyle(
                            color: Colors.blue,
                          )),
                    ],
                  ),
                  Text('FORGOT PASSWORD?',
                      style: TextStyle(
                        color: Colors.blue,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showPassword() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void handleClick() {
    if (bloc.isValidInfo(_usernameController.text, _passwordController.text)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  Widget redirectHomeScreen(BuildContext context) {
    return Home();
  }
}
