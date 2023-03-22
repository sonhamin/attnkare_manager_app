import 'package:attnkare_manager_app/components/job_card.dart';
import 'package:attnkare_manager_app/models/job_model.dart';
import 'package:attnkare_manager_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;

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
                children: [
                  badges.Badge(
                    position:
                        badges.BadgePosition.bottomEnd(bottom: 20, end: 30),
                    showBadge: true,
                    ignorePointer: false,
                    onTap: () {},
                    badgeContent: Text(
                      '${widget.user.grade}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    badgeAnimation: const badges.BadgeAnimation.rotation(
                      animationDuration: Duration(seconds: 1),
                      colorChangeAnimationDuration: Duration(seconds: 1),
                      loopAnimation: true,
                      curve: Curves.fastOutSlowIn,
                      colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      badgeColor: Colors.red.shade700,
                      padding: const EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(90),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                      elevation: 2,
                    ),
                    child: const CircleImageWidget(),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Text(
                    'Hello, ${widget.user.uid}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Text(
                'Your Jobs',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              FutureBuilder(
                future: ApiService.getJobList(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<JobModel?> jobs = snapshot.data!;
                    return jobs.isEmpty
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 44.0, horizontal: 20.0),
                                child: Text(
                                  'Empty.😱',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: jobs
                                .map((JobModel? job) => JobCardWidget(
                                      jobModel: job!,
                                    ))
                                .toList(),
                          );
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
    setState(() {
      print('onPressed');
    });
  }
}
