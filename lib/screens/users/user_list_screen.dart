import 'package:attnkare_manager_app/models/user_info_model.dart';
import 'package:attnkare_manager_app/screens/users/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_service.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final Map<String, dynamic> user = {'id': null, 'name': 'Elixian', 'age': 20};

  late Future<List<UserInfoModel?>> userInfoList;
  late final SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    userInfoList = ApiService.getUserInfoList('1');

    initPref();
  }

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('liked');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white70,
        foregroundColor: Colors.green.shade700,
        automaticallyImplyLeading: false,
        actions: const [],
        title: const Text(
          'User List',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            height: 1.0,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 100,
        cacheExtent: 20.0,
        controller: ScrollController(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (BuildContext context, int index) {
          user['id'] = index;
          return UserCard(user: user);
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var itemId = user['id'];

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserDetailScreen(
                title: 'titleLarge',
                thumb: 'thumb',
                id: 'id',
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.primaries[itemId % Colors.primaries.length],
          ),
          title: Text(
            'Item $itemId',
            key: Key('text_$itemId'),
          ),
          trailing: IconButton(
            key: Key('icon_$itemId'),
            icon: const Icon(Icons.favorite),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Added to favorites.',
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
