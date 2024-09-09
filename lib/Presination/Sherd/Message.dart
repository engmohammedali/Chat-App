import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:chatapp/Provider/ChatMicOrSend.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MessageBubble extends StatelessWidget {
  final String message; // نص الرسالة
  final bool isRead; // تحديد ما إذا كانت الرسالة قد تمت قراءتها
  final bool isMe; // تحديد إذا كانت الرسالة مرسلة من المستخدم الحالي
  final bool isImage; // متغير جديد لتحديد إذا كانت الرسالة تحتوي على صورة
  final DateTime time;
  final bool isVoice;
  const MessageBubble({
    super.key,
    required this.message,
    required this.isVoice,
    required this.isRead,
    required this.isMe,
    required this.isImage,
    required this.time,

    // ما إذا كانت الرسالة تحتوي على صورة
  });

  @override
  Widget build(BuildContext context) {
    return isVoice
        ? Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Consumer<Chatmicorsend>(
              builder: (BuildContext context, value, Widget? child) {
                return BubbleNormalAudio(
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                  color: isMe ? Color(0xFF003366) : Color(0xFF000000),
                  duration: value.duration.inSeconds.toDouble(),
                  position: value.position.inSeconds.toDouble(),
                  isPlaying: value.isPlaying,
                  isLoading: value.isLoading,
                  isPause: value.isPause,
                  onSeekChanged: (e) {},
                  onPlayPauseButtonClick: () async {
                    if (!value.isPlaying) {
                      await value.play(url: message);
                    } else {
                      await value.stop_play();
                    }
                  },
                  sent: isMe,
                  seen: isRead,
                );
              },
            ),
          )
        : Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: 4, horizontal: 12), // المسافة حول الفقاعة
              padding: EdgeInsets.symmetric(
                  vertical: 4, horizontal: 6), // مسافة داخل الفقاعة
              decoration: BoxDecoration(
                color:
                    isMe ? Color(0xFF003366) : Color(0xFF333333 ), // لون الفقاعة
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: isMe ? Radius.circular(15) : Radius.circular(0),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // عرض محتوى الفقاعة (نص أو صورة)
                  if (isImage)
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xFF000000),
                                ),
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                height: double.infinity,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      fit: BoxFit.cover,
                                      imageUrl: message,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey[850]!,
                                        highlightColor: Colors.grey[800]!,
                                        child: Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF333333),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),

                                  //  ClipRRect(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   child: Image.network(
                                  //     width: double.infinity,
                                  //     height:
                                  //         MediaQuery.of(context).size.height *
                                  //             0.6,
                                  //     message, // رابط الصورة
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                ),
                              );
                            },
                            isScrollControlled: true);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              imageUrl: message,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor: Colors.grey[800]!,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                              right: -3,
                              bottom: -3,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      DateFormat("hh:mm a")
                                          .format(time)
                                          .toString(), // الوقت ثابت هنا، يمكنك تخصيصه
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            1), // المسافة بين الوقت والأيقونة
                                    Icon(
                                      isMe
                                          ? isRead
                                              ? Icons.done_all
                                              : Icons.check
                                          : null,
                                      size: 16,
                                      color: isRead
                                          ? Colors.blue
                                          : Colors.white70,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    )
                  else
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                            "${message}               ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -3,
                          bottom: -3,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  DateFormat("hh:mm a")
                                      .format(time)
                                      .toString(), // الوقت ثابت هنا، يمكنك تخصيصه
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(
                                    width: 1), // المسافة بين الوقت والأيقونة
                                Icon(
                                  isMe
                                      ? isRead
                                          ? Icons.done_all
                                          : Icons.check
                                      : null,
                                  size: 16,
                                  color: isRead ? Colors.blue : Colors.white70,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  // مساحة صغيرة بين النص أو الصورة والأيقونة
                ],
              ),
            ),
          );
  }
}
