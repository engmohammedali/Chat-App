import 'package:chatapp/Presination/Screen/RegistorScreen.dart';
import 'package:chatapp/Presination/Screen/login.dart';
import 'package:chatapp/Presination/Sherd/MyButtom.dart';
import 'package:flutter/material.dart';

class Welcomescreen extends StatefulWidget {
  static const String screenRoute = "WelomeScreen";
  Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    height: 160,
                    child: Image.asset("assets/logo.png"),
                  ),
                  const Text(
                    "MessageMe",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff2e386b)),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              MyButton(
                  title: "Log in",
                  color: Colors.yellow[900]!,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }),
              // Navigator.pushNamed(context, LoginScreen.screenRoute);

              MyButton(
                  title: "register",
                  color: Colors.blue[800]!,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registorscreen(
                                  isUpdate: false,
                                  data: {},
                                )));
                    // Navigator.pushNamed(context, Registorscreen.screenRoute);
                  }),
            ],
          ),
        ));
  }
}
