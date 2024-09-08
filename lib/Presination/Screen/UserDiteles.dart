import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Presination/Sherd/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Userditeles extends StatelessWidget {
  final Map data;
  const Userditeles({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: BTNgreen),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 70),
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
                  imageUrl: data['imgProfile'].toString(),
                  placeholder: (context, url) => Shimmer.fromColors(
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Divider(
              thickness: 1,
              height: 1.5,
              color: Colors.white,
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              data['username'],
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 22,
            ),
            Divider(
              thickness: 1,
              height: 1.5,
              color: Colors.white,
            ),
            SizedBox(
              height: 22,
            ),
            Text(
              data['email'],
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
