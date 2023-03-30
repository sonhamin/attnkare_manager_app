import 'package:attnkare_manager_app/screens/users/user_list_screen.dart';
import 'package:flutter/material.dart';

class SideNavigationDrawer extends StatefulWidget {
  const SideNavigationDrawer({super.key});

  @override
  State<SideNavigationDrawer> createState() => _SideNavigationDrawerState();
}

class _SideNavigationDrawerState extends State<SideNavigationDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  buildHeader(BuildContext context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          color: Colors.blue.shade600,
          child: Column(
            children: [
              CircleAvatar(
                radius: 58,
                backgroundColor: Colors.primaries[11 % Colors.primaries.length],
                backgroundImage: const AssetImage('assets/icons/pig.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'name',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              const Text(
                'uid',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const UserListScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.devices_rounded),
              title: const Text('Device'),
              onTap: () {},
            ), // ListTile
            ListTile(
              leading: const Icon(Icons.man_2_outlined),
              title: const Text('Info'),
              onTap: () {},
            ),
            Divider(
              color: Colors.black54.withAlpha(75),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      );
}
// bluekare_doctor