import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_dispatcher/nav_bar.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const Navbar(),
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: true,
          title: const Text(
            "Диспетчерская",
            style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: bodyBackground,
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('transports').snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: white,
                    child: ListTile(
                      leading: SvgPicture.asset('assets/images/Truck.svg'),
                    ),
                  );
                });
          },
        ));
  }
}
