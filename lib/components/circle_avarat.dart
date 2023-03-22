// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final String imageUrl;

  const CircleImageWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade300,
      radius: 180,
      child: CircleAvatar(
        radius: 160,
        backgroundColor: Colors.green,
        backgroundImage: NetworkImage(
          imageUrl,
        ),
      ),
    );
  }
}
