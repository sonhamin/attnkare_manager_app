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
  late Future<List<UserInfoModel?>> patientInfoList;
  late final SharedPreferences prefs;

  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    initPref();
  }

  void initPref() {
    managerInfo = ApiService.getManagerInfo();
    patientInfoList = ApiService.getPatientList();
    // setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white70,
        foregroundColor: Colors.green.shade700,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => onPressed(context),
            icon: const Icon(Icons.add_circle_outline_outlined),
          ),
        ],
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

  void onPressed(BuildContext context) {
    List<dynamic> patients = [];
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          //3
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState) {
            return DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.4,
                maxChildSize: 0.8,
                expand: false,
                builder: (BuildContext context, ScrollController controller) {
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(children: [
                        Expanded(
                            child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(),
                            ),
                            prefixIcon: const Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            if (value.length > 1) {
                              searchPatient(value).then((value) {
                                patients.clear();
                                patients.addAll(value);
                                bottomState(() {});
                                setState(() {});
                              });
                            }
                          },
                        )),
                        IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          color: const Color(0xFF1F91E7),
                          onPressed: () {
                            setState(() {
                              textController.clear();
                              patients.clear();
                            });
                          },
                        ),
                      ]),
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: controller,
                        itemCount: patients.length,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  patients[index].name ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Inter-Regular',
                                    fontSize: 24,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ApiService.regisgerPatient(
                                        patients[index].id);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.person_2_rounded),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ]);
                });
          });
        }).whenComplete(() {
      setState(() {
        // ApiService.getPatientList();
        // 다시 조회하지 않아도 FutureBuilder를 setState하면 다시 build()한다.
      });
    });
  }
}

Future<List> searchPatient(String term) async {
  return await ApiService.searchPatient(term, 5);
}

class UserCard extends StatelessWidget {
  final UserInfoModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var itemId = user.id;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return UserDetailScreen(
              user: user,
            );
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.primaries[itemId % Colors.primaries.length],
            backgroundImage: const NetworkImage(
              'https://static.thenounproject.com/png/2934238-200.png',
            ),
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
// bluekare_doctor