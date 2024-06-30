import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_dispatcher/database/auth_service.dart';
import 'package:flutter_dispatcher/global.dart' as globals;

final colRef = FirebaseFirestore.instance.collection('profiles');

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  dynamic userDoc;

  getUserById() async {
    if (auth.currentUser == null) {
      return;
    }
    final String userId = auth.currentUser!.uid.toString();
    final DocumentSnapshot documentSnapshot = await colRef.doc(userId).get();
    setState(() {
      userDoc = documentSnapshot;
    });
  }

  @override
  void initState() {
    getUserById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              // "Dinar",
              auth.currentUser != null ? userDoc['name'] : '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            accountEmail: Text(
              auth.currentUser == null
                  ? ''
                  : auth.currentUser!.email.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            currentAccountPicture: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: CircleAvatar(
                backgroundColor: bodyBackground,
                child: ClipOval(
                    child: auth.currentUser != null
                        ? userDoc['image'] == ''
                            ? (globals.selectImage == null
                                ? const Icon(
                                    Icons.person_3_rounded,
                                    color: buttonColor,
                                    size: 50,
                                  )
                                : Image.file(
                                    globals.selectImage!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ))
                            : Image.network(
                                userDoc['image'],
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                        : const CircleAvatar(
                            radius: 50,
                            backgroundColor: white,
                            child: Icon(
                              size: 50,
                              Icons.person_3_rounded,
                              color: buttonColor,
                            ),
                          )),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover),
            ),
          ),
          auth.currentUser != null
              ? ListTile(
                  leading: const Icon(
                    Icons.person_pin_rounded,
                  ),
                  title:
                      const Text("Мой профиль", style: TextStyle(fontSize: 16)),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/profile');
                  })
              : const SizedBox(),
          ListTile(
            leading: Icon(Icons.apartment_rounded),
            title: const Text(
              "О нашей компании",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/about');
            },
          ),
          ListTile(
            leading: const SizedBox(),
            title: const Text(
              "Контакты",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/contacts');
            },
          ),
          auth.currentUser != null
              ? ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text(
                    "Выйти",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    AuthService().logOut();
                    Navigator.pushReplacementNamed(context, '/auth');
                  },
                )
              : ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text(
                    "Войти",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/auth');
                  },
                ),
        ],
      ),
    );
  }
}
