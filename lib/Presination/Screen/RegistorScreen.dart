import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Firebase/MethedFirebaseAuth.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/BlocAuth.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/EventsRegisterEventsRegister.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/StateRegister.dart';
import 'package:chatapp/Presination/Screen/ChatApp.dart';
import 'package:chatapp/Presination/Sherd/Colors.dart';
import 'package:chatapp/Presination/Sherd/MyButtom.dart';
import 'package:chatapp/Presination/Sherd/SnackBar.dart';
import 'package:chatapp/Presination/Sherd/decoration.dart';
import 'package:chatapp/Provider/UserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import 'package:shimmer/shimmer.dart';

class Registorscreen extends StatefulWidget {
  late Map data;
  static const String screenRoute = "Registorscreen";
  bool isUpdate = false;
  Registorscreen({super.key, required this.isUpdate, required this.data});

  @override
  State<Registorscreen> createState() => _RegistorscreenState();
}

class _RegistorscreenState extends State<Registorscreen> {
  Uint8List? imgPath;

  String? imgName;
  bool isloading = false;

  bool isvisblity = false;
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();

  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "Camera",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "Gallery",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    if (widget.isUpdate) {
      emailController.text = widget.data['email'];
      usernameController.text = widget.data['username'];
      passwordController.text = widget.data['password'];
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isUpdate
          ? AppBar(
            
              iconTheme: IconThemeData(color: Colors.white),
              centerTitle: true,
              backgroundColor: BTNgreen,
              title: Text(
                "Update Profile",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
      backgroundColor: widget.isUpdate ? Colors.black : Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: widget.isUpdate ? null : const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      widget.isUpdate
                          ? Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: BTNgreen,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      widget.data['imgProfile'].toString(),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[850]!,
                                    highlightColor: Colors.grey[800]!,
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            )
                          : imgPath == null
                              ? const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 225, 225, 225),
                                  radius: 71,
                                  backgroundImage:
                                      AssetImage("assets/avatar.png"),
                                )
                              : CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 225, 225, 225),
                                  radius: 71,
                                  backgroundImage: MemoryImage(imgPath!),
                                ),
                      Positioned(
                        left: 99,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () {
                            showmodel();
                          },
                          icon: const Icon(Icons.add_a_photo),
                          color: Color.fromARGB(255, 208, 218, 224),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: widget.isUpdate ? TextStyle(color: Colors.white) : null,
                validator: (username) {
                  return username!.isNotEmpty ? null : "Enter a valid username";
                },
                controller: usernameController,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: decoration.copyWith(
                    suffixIcon: Icon(Icons.person),
                    hintText: "username",
                    enabledBorder: widget.isUpdate
                        ? OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: BTNgreen),
                            borderRadius: BorderRadius.all(Radius.circular(10)))
                        : null),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                  style:
                      widget.isUpdate ? TextStyle(color: Colors.white) : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) {
                    return email!.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                        ? null
                        : "Enter a valid email";
                  },
                  controller: emailController,
                  textAlign: TextAlign.center,
                  onChanged: (value) {},
                  decoration: decoration.copyWith(
                      suffixIcon: Icon(Icons.email),
                      enabledBorder: widget.isUpdate
                          ? OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: BTNgreen),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))
                          : null)),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                  style:
                      widget.isUpdate ? TextStyle(color: Colors.white) : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (pass) =>
                      pass!.length > 6 ? null : "Enter a valid password",
                  controller: passwordController,
                  textAlign: TextAlign.center,
                  obscureText: isvisblity ? false : true,
                  onChanged: (value) {},
                  decoration: decoration.copyWith(
                      hintText: "Enter password",
                      enabledBorder: widget.isUpdate
                          ? OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: BTNgreen),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))
                          : null,
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
              BlocBuilder<BlocAuth, StateAuth>(
                builder: (context, state) {
                  if (state is StateregisterLoading) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 21, 101, 192),
                      )),
                    );
                  } else if (state is StateregisterSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => showSnackBar(context, "Success Register"));
                    WidgetsBinding.instance.addPostFrameCallback((_) =>
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Chatapp())));
                  } else if (state is StateregisterError) {
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => showSnackBar(context, state.error));
                  }
                  return isloading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 21, 101, 192),
                          )),
                        )
                      : MyButton(
                          title: widget.isUpdate ? "Upload " : "Register",
                          color: widget.isUpdate ? BTNgreen : Colors.blue[800]!,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (widget.isUpdate) {
                                await inTapUpdateUser();
                              } else {
                                context.read<BlocAuth>().add(EventsRegisterGo(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      username: usernameController.text,
                                      imgPath: imgPath!,
                                      imgName: imgName!,
                                    ));
                              }
                            }
                          });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  inTapUpdateUser() async {
    setState(() {
      isloading = true;
    });

    if (imgPath == null) {
      await Methedfirebaseauth.UpdateUser(
          uid: widget.data['uid'],
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          imgPorfile: widget.data['imgProfile']);

      setState(() {
        isloading = false;
      });
    } else {
      await Methedfirebaseauth.UpdateUserWhitImg(
          uid: widget.data['uid'],
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          imgName: imgName!,
          imgPath: imgPath!);
    }

    await UserProvider().refreshUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Chatapp()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }
}
