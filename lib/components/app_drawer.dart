import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:women/services/auth_methods.dart';
import 'package:women/services/shared_preferences.dart';
import 'package:women/views/laws.dart';
import 'package:women/views/settings.dart';
import 'package:women/views/signin.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String userName = "", userEmail = "", imageURL = "";

  @override
  void initState() {
    super.initState();
    SharedPreferenceHelper.getUserNameKey().then((value) => setState(() => userName = value ?? ""));
    SharedPreferenceHelper.getUserEmail().then((value) => setState(() => userEmail = value ?? ""));
    SharedPreferenceHelper.getUserProfilePicKey()
        .then((value) => setState(() => imageURL = value ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: imageURL != ""
                ? const Icon(Icons.account_circle_rounded, size: 55)
                : CircleAvatar(backgroundImage: NetworkImage(imageURL)),
          ),
          ListTile(
            title: const Text("Settings"),
            subtitle: const Text("SOS delay, Edit SOS message"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Settings()),
            ),
            trailing: const FittedBox(
              child: Icon(Icons.settings, size: 25),
            ),
          ),
          ListTile(
            title: const Text("Info, Laws, etc."),
            subtitle: const Text("Stay up to date on indian laws..."),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Laws()),
            ),
            trailing: const FittedBox(
              child: Icon(Icons.info, size: 25),
            ),
          ),
          ListTile(
            title: const Text("Logout"),
            tileColor: Colors.grey[300],
            onTap: () {
              AuthMethods().signOut().then((_) {
                AwesomeNotifications().dismissAllNotifications();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
              });
            },
            trailing: SvgPicture.asset("assets/icons/log-out.svg", height: 25),
          ),
        ],
      ),
    );
  }
}
