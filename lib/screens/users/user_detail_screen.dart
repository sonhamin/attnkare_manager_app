import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_detail_model.dart';
import '../../services/api_service.dart';

class UserDetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const UserDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<UserDetailModel?> user;

  late final SharedPreferences prefs;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    user = ApiService.getUserDetail(widget.id);

    initPref();
  }

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('liked');

    if (likedToons != null) {
      isLiked = likedToons.contains(widget.id);
    } else {
      await prefs.setStringList('liked', []);
    }

    setState(() {});
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
            icon: Icon(isLiked
                ? Icons.favorite_outlined
                : Icons.favorite_outline_outlined),
          ),
        ],
        title: Text(
          widget.title,
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
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: const Offset(5, 5),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ]),
                    clipBehavior: Clip.hardEdge,
                    width: 320,
                    // child: Image.network(widget.thumb),
                    child: const Icon(
                      Icons.audiotrack,
                      color: Colors.green,
                      size: 30.0,
                      semanticLabel: 'Track',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text(
                          snapshot.data!.id,
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
                          "${snapshot.data!.rating} / ${snapshot.data!.title}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text("Loading...");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed() async {
    final likedToons = prefs.getStringList('liked');
    if (isLiked) {
      likedToons!.remove(widget.id);
    } else {
      likedToons!.add(widget.id);
    }
    await prefs.setStringList('liked', likedToons);
    print(likedToons);

    setState(() {
      isLiked = !isLiked;
    });
  }
}
