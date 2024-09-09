import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Firebase/MethedFirebaseAuth.dart';
import 'package:chatapp/Firebase/getImgURL.dart';
import 'package:chatapp/Presination/Screen/UserDiteles.dart';
import 'package:chatapp/Presination/Sherd/Colors.dart';
import 'package:chatapp/Presination/Sherd/Message.dart';
import 'package:chatapp/Presination/Sherd/MyButtom.dart';
import 'package:chatapp/Presination/Sherd/decoration.dart';
import 'package:chatapp/Presination/Sherd/getRoomChat.dart';
import 'package:chatapp/Provider/ChatMicOrSend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  static const String screenRoute = "ChatScreen";
  Map data;
  ChatScreen({required this.data});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final plyer = AudioPlayer();
//=============================================================

  ///=======================================================
  bool isloading = true;
  Uint8List? imgPath;
  String? imgName;
  late String uidChat;
  late final allDataFromDB;
  var user = FirebaseAuth.instance.currentUser;
  var messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    context.read<Chatmicorsend>().audioPlayer.dispose();
    messageController.clear();
  }

  showImg() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.memory(
                  imgPath!,
                  width: 200,
                  height: 200,
                  // fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 10,
                ),
                MyButton(
                    title: 'Send',
                    color: BTNgreen,
                    onPressed: () async {
                      String urlDownload =
                          await getImgURL(imgName: imgName!, imgPath: imgPath!);
                      await Methedfirebaseauth.chatWhitUser(
                          uidChat: uidChat,
                          uidmessage: const Uuid().v1(),
                          uid: widget.data['uid'],
                          uidSender: user!.uid,
                          time: DateTime.now(),
                          message: urlDownload,
                          type: 'img');

                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    context.read<Chatmicorsend>().audioPlayer = AudioPlayer();
    uidChat = getRoomCgat(user1: user!.uid, user2: widget.data['uid']);
    Methedfirebaseauth.createChat(
        uidChat: uidChat,
        usernametoSend: widget.data['username'],
        uidSender: user!.uid,
        uidtoSend: widget.data['uid'],
        imgPortofileSend: widget.data['imgProfile'],
        time: DateTime.now(),
        emailtoSend: widget.data['email']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // allDataFromDB = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: BTNgreen,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Userditeles(
                          data: widget.data,
                        )));
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  width: 47,
                  height: 47,
                  fit: BoxFit.cover,
                  imageUrl: widget.data['imgProfile'],
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(width: 7),
              Expanded(
                child: Text(
                  widget.data['username'],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Colors.white,
              )),
          PopupMenuButton(
              iconColor: Colors.white,
              color: Colors.black,
              itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Text(
                        "Seaarch",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: "1",
                      onTap: () {},
                    ),
                    PopupMenuItem(
                      child: Text(
                        "Clear Chat",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: "2",
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection("chat")
                            .doc(uidChat)
                            .delete();

                        Navigator.pop(context);
                      },
                    )
                  ])
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/background.jpg",
                ),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chat")
                    .doc(uidChat)
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: BTNgreen,
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView(
                      reverse: true,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        Methedfirebaseauth.readMessage(
                            state: true, uid: user!.uid, uidChat: uidChat);

                        if (data['type'] == 'img') {
                          return Dismissible(
                            onDismissed: (direction) async {
                              FirebaseFirestore.instance
                                  .collection('chat')
                                  .doc(uidChat)
                                  .collection("messages")
                                  .where('uidmessage',
                                      isEqualTo: data['uidmessage'])
                                  .get()
                                  .then((QuerySnapshot snapshot) {
                                if (snapshot.docs.isNotEmpty) {
                                  snapshot.docs.first.reference.delete();
                                }
                              });
                            },
                            direction: DismissDirection.horizontal,
                            key: Key(data['uidmessage']),
                            secondaryBackground: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            background: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: MessageBubble(
                              message: data["message"],
                              isRead: data['state'],
                              isMe: data['uid'] != user!.uid,
                              time: data['time'].toDate(),
                              isImage: true,
                              isVoice: false,
                            ),
                          );
                        } else if (data['type'] == 'voice') {
                          return MessageBubble(
                            message: data["message"],
                            isRead: data['state'],
                            isMe: data['uid'] != user!.uid,
                            time: data['time'].toDate(),
                            isImage: false,
                            isVoice: true,
                          );
                        } else {
                          return MessageBubble(
                            message: data["message"],
                            isRead: data['state'],
                            isMe: data['uid'] != user!.uid,
                            time: data['time'].toDate(),
                            isImage: false,
                            isVoice: false,
                          );
                        }
                      }).toList(),
                    ),
                  );
                }),
            footerChat()
          ],
        ),
      ),
    );
  }

  Widget footerChat() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: messageController,
              onChanged: (value) {
                context.read<Chatmicorsend>().checLength(value.length);
              },
              decoration: decoration.copyWith(
                  hintText: "Typing a message",
                  fillColor: Colors.white,
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w700, color: BTNgreen),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  prefixIcon: IconButton(
                      onPressed: () async {
                        await showmodel();
                      },
                      icon: Icon(
                        Icons.add,
                        color: BTNgreen,
                      ))),
            ),
          ),
          Consumer<Chatmicorsend>(
            builder: (BuildContext context, value, child) {
              return value.state
                  ? IconButton(
                      onPressed: () async {
                        await Methedfirebaseauth.chatWhitUser(
                            uidmessage: const Uuid().v1(),
                            uidChat: uidChat,
                            uid: widget.data['uid'],
                            uidSender: user!.uid,
                            time: DateTime.now(),
                            message: messageController.text,
                            type: "message");

                        messageController.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: BTNgreen,
                      ))
                  : value.stateMic
                      ? IconButton(
                          onPressed: () async {
                            context.read<Chatmicorsend>().checTapMic(false);
                            await value.stop_Record();
                            await Methedfirebaseauth.chatWhitUser(
                                uidmessage: const Uuid().v1(),
                                uidChat: uidChat,
                                uid: widget.data['uid'],
                                uidSender: user!.uid,
                                time: DateTime.now(),
                                message: value.url,
                                type: "voice");
                          },
                          icon: Icon(
                            Icons.stop,
                            color: BTNgreen,
                          ))
                      : IconButton(
                          onPressed: () async {
                            context.read<Chatmicorsend>().checTapMic(true);

                            await value.start_Record();
                          },
                          icon: Icon(
                            Icons.mic,
                            color: BTNgreen,
                          ));
            },
          ),
        ],
      ),
    );
  }

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
        return showImg();
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
      builder: (constext) {
        return Container(
          padding: const EdgeInsets.all(10),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: GestureDetector(
                  onTap: () async {
                    await uploadImage2Screen(ImageSource.camera);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.camera_alt, size: 28, color: Colors.black),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 35,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      Icon(Icons.photo, size: 28, color: Colors.black),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
