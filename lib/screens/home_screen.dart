import 'package:flutter/material.dart';
import 'package:flutter_login/app_router/app_route_constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Messages'),
              onTap: () => context.push(AppRouteConstants.messages),
            ),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                context.go(AppRouteConstants.login);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              'assets/images/hamburger.svg',
              width: 24,
              height: 24,
              color: Colors.black, // optional tint
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(widget.title),
        backgroundColor: Colors.white,
      ),
      body: const Center(child: Text('Home Screen')),
    );
  }
}
