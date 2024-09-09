import 'package:chatapp/Presination/Contro/BlocAuth/BlocAuth.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/EventsLogin.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/StateLogin.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/StateRegister.dart';
import 'package:chatapp/Presination/Screen/ChatApp.dart';
import 'package:chatapp/Presination/Sherd/MyButtom.dart';
import 'package:chatapp/Presination/Sherd/SnackBar.dart';
import 'package:chatapp/Presination/Sherd/decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String screenRoute = "LoginScreen";
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isvisblity = false;
  var emailController = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                child: Image.asset("assets/logo.png"),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                  controller: emailController,
                  textAlign: TextAlign.center,
                  onChanged: (value) {},
                  decoration:
                      decoration.copyWith(suffixIcon: Icon(Icons.email))),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                  controller: password,
                  textAlign: TextAlign.center,
                  obscureText: isvisblity ? false : true,
                  decoration: decoration.copyWith(
                      hintText: "Enter password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isvisblity = !isvisblity;
                            });
                          },
                          icon: isvisblity
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)))),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<BlocAuth, StateAuth>(builder: (context, state) {
                if (state is StateLoginLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 245, 127, 23),
                    )),
                  );
                } else if (state is StateLoginSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => showSnackBar(context, "Success Register"));

                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      WidgetsBinding
                          .instance
                          .addPostFrameCallback((_) =>
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chatapp()))));
                } else if (state is StateLoginError) {
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => showSnackBar(context, "Login Error"));
                }
                return MyButton(
                    title: "Log in",
                    color: Colors.yellow[900]!,
                    onPressed: () async {
                      context.read<BlocAuth>().add(EventsloginGo(
                          email: emailController.text,
                          password: password.text));
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
