import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women/colors.dart';
import 'package:women/services/database_methods.dart';
import 'package:women/services/sos_notification_methods.dart';
import 'package:women/views/add_contact.dart';

class BottomContent extends StatelessWidget {
  const BottomContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Send Emergency",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 21),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 16.0),
            child: Text(
              "SOS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final databaseMethods = DatabaseMethods();
                int count = await databaseMethods.getCount();
                if (count == 0) {
                  Fluttertoast.showToast(msg: 'Please Add Trusted contacts to send SOS.');
                } else {
                  Fluttertoast.showToast(msg: 'Sending SOS...');
                  SosNotificationMethods.initiateSosProgressNotification(1337);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: bigRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
              ),
              child: SvgPicture.asset(
                "assets/icons/alert.svg",
                height: 100,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 60, left: 60),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddContacts()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
                foregroundColor: Colors.blueGrey,
                padding: const EdgeInsets.all(4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: SvgPicture.asset(
                      "assets/icons/add_alert.svg",
                      colorFilter: const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
                    ),
                  ),
                  const Text(
                    "Add Contacts",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
