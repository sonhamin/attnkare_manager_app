import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/circle_avarat.dart';
import '../../models/user_info_model.dart';

class UserDetailScreen extends StatefulWidget {
  final UserInfoModel user;

  const UserDetailScreen({
    super.key,
    required this.user,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late final UserInfoModel user;

  late final SharedPreferences prefs;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white70,
        foregroundColor: Colors.green.shade700,
        actions: [
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add_a_photo_outlined),
          ),
        ],
        title: Text(
          widget.user.nameAsterisk ?? "Kid_${widget.user.id}",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleImageWidget(),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Text(
                    'user id: ${widget.user.uid}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'user grade: ${widget.user.grade}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed() async {
    setState(() {
      print('onPressed');
    });
  }
}
