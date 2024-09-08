import 'package:chatapp/Presination/Screen/ChatApp.dart';
import 'package:chatapp/Presination/Screen/WelcomeScrean.dart';
import 'package:chatapp/Presination/Sherd/Colors.dart';
import 'package:chatapp/Presination/Sherd/Profile.dart';
import 'package:chatapp/Provider/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Mydrawer extends StatefulWidget {
  Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _launchURL() async {
    var whatsappNumber = '+37060683712';
    String whatsappUrl = 'https://wa.me/$whatsappNumber';
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;
    return Drawer(
      backgroundColor: Colors.black,
      child: SizedBox(
           width: 300,
           
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(data: {
                                  "email": allDataFromDB.email,
                                  "username": allDataFromDB.username,
                                  "imgProfile": allDataFromDB.imgProfile,
                                  'uid': allDataFromDB.uid,
                                  'password': allDataFromDB.password
                                })));
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: BTNgreen),
                    currentAccountPicture: ClipRRect(
                      child: Image.network(
                        allDataFromDB!.imgProfile!,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    accountEmail: Text(allDataFromDB.email),
                    accountName: Text(allDataFromDB.username,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Chatapp()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.support_agent, color: Colors.white),
                  title: Text(
                    "Support Team",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: _launchURL,
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text("Profile", style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text(
                    "Setting",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text(
                    "Log out",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
        
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Welcomescreen()),
                        (Route<dynamic> route) => false);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Welcomescreen()));
                  },
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  child: Text(
                    "Deployed By :Mohammed Ali © 2024",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
