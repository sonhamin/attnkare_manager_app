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
  late Future<UserInfoModel?> managerInfo;
  late final SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    initPref();
  }

  void initPref() {
    ApiService.getManagerInfo().then((value) => print('then : $value'));

    managerInfo = ApiService.getManagerInfo();

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
          'Children',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            height: 1.0,
          ),
        ),
      ),
      body: FutureBuilder(
        future: ApiService.getPatientList(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<UserInfoModel?> patients = snapshot.data!;
            return ListView.builder(
              itemCount: patients.length,
              cacheExtent: 20.0,
              controller: ScrollController(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return UserCard(user: patients[index]!);
              },
            );
          }
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserInfoModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var itemId = user.id;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailScreen(
                user: user,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.primaries[itemId % Colors.primaries.length],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.nameAsterisk ?? 'noname',
                key: Key('name_${user.id}'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                user.uid,
                key: Key('uid_${user.id}'),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Poppins",
                ),
              )
            ],
          ),
          trailing: IconButton(
            key: Key('icon_${user.id}'),
            icon: user.gender == Gender.male
                ? const Icon(Icons.male_rounded)
                : const Icon(Icons.female_rounded),
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
