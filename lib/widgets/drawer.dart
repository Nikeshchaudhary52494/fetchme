import 'package:fetchme/screens/add_product_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'lib/images/fetchme.png',
                  color: const Color.fromARGB(255, 18, 181, 135),
                  width: 300,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24),
                child: ListTile(
                  leading: Icon(
                    Icons.light_mode,
                  ),
                  title: Text(
                    "Theme",
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24),
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                  ),
                  title: Text(
                    "about",
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductForm()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: ListTile(
                    leading: Icon(
                      Icons.add,
                    ),
                    title: Text(
                      "Add product",
                    ),
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: signUserOut,
            child: const Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                left: 24,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                ),
                title: Text(
                  "Logout",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
