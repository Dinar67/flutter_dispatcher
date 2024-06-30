import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_dispatcher/nav_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:flutter_dispatcher/global.dart' as globals;

final FirebaseFirestore db = FirebaseFirestore.instance;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        floatingActionButton: globals.currentUser != null &&
                globals.currentUser!.get('role') == 'admin'
            ? FloatingActionButton(
                onPressed: () {
                  nameController.text = '';
                  dropValue = null;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const alertTransport();
                      });
                },
                backgroundColor: buttonColor,
                child: const Icon(
                  Icons.add,
                  color: white,
                ),
              )
            : const SizedBox(),
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
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (FirebaseAuth.instance.currentUser == null ||
                          globals.currentUser!.get('role') == 'user') {
                        return;
                      }
                      globals.selectedTransport = snapshot.data!.docs[index];
                      Navigator.popAndPushNamed(context, '/driver');
                    },
                    child: Card(
                        color: white,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (snapshot.data!.docs[index].get('type') ==
                                      'truck')
                                    SvgPicture.asset('assets/images/Truck.svg'),
                                  if (snapshot.data!.docs[index].get('type') ==
                                      'bus')
                                    SvgPicture.asset('assets/images/Bus.svg'),
                                  if (snapshot.data!.docs[index].get('type') ==
                                      'car')
                                    SvgPicture.asset('assets/images/Car.svg'),
                                  if (snapshot.data!.docs[index].get('type') ==
                                      'motorcycle')
                                    SvgPicture.asset(
                                        'assets/images/Motorcycle.svg'),
                                  if (snapshot.data!.docs[index].get('type') ==
                                      'tuktuk')
                                    SvgPicture.asset(
                                        'assets/images/Tuktuk.svg'),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index].get('name'),
                                        style: const TextStyle(
                                            color: black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Водитель: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                .get('driverName'),
                                            style: const TextStyle(
                                                color: black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  globals.currentUser != null &&
                                          globals.currentUser!.get('role') ==
                                              'admin'
                                      ? IconButton(
                                          onPressed: () async {
                                            await snapshot
                                                .data!.docs[index].reference
                                                .delete();
                                            Toast.show('Успешно удалено!');
                                          },
                                          icon: const Icon(Icons.delete))
                                      : const SizedBox(),
                                  FilledButton(
                                      onPressed: () async {
                                        if (FirebaseAuth.instance.currentUser ==
                                                null ||
                                            globals.currentUser!.get('role') ==
                                                'user') {
                                          return;
                                        }

                                        globals.selectedTransport =
                                            snapshot.data!.docs[index];
                                        Navigator.popAndPushNamed(
                                            context, '/status');
                                      },
                                      style: FilledButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      child: Row(
                                        children: [
                                          if (snapshot.data!.docs[index]
                                                  .get('status') ==
                                              'boarding')
                                            SvgPicture.asset(
                                                'assets/images/state_boarding.svg'),
                                          if (snapshot.data!.docs[index]
                                                  .get('status') ==
                                              'delivery')
                                            SvgPicture.asset(
                                                'assets/images/state_delivery.svg'),
                                          if (snapshot.data!.docs[index]
                                                  .get('status') ==
                                              'load')
                                            SvgPicture.asset(
                                                'assets/images/state_load.svg'),
                                          if (snapshot.data!.docs[index]
                                                  .get('status') ==
                                              'parking')
                                            SvgPicture.asset(
                                                'assets/images/state_parking.svg'),
                                          if (snapshot.data!.docs[index]
                                                  .get('status') ==
                                              'pickup')
                                            SvgPicture.asset(
                                                'assets/images/state_pickup.svg'),
                                          if (snapshot.data!.docs[index]
                                                  .get('status') ==
                                              'repair')
                                            SvgPicture.asset(
                                                'assets/images/state_repair.svg'),
                                          if (snapshot.data!.docs[index]
                                                  .get('status') ==
                                              'unboarding')
                                            SvgPicture.asset(
                                                'assets/images/state_unboarding.svg'),
                                        ],
                                      )),
                                ],
                              )
                            ],
                          ),
                        )),
                  );
                });
          },
        ));
  }
}

final items = ['car', 'truck', 'bus', 'motorcycle', 'tuktuk'];
DocumentSnapshot? selectedDriver;
final TextEditingController nameController = TextEditingController();
String? dropValue;

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(color: black),
    ));

class alertTransport extends StatefulWidget {
  const alertTransport({super.key});

  @override
  State<alertTransport> createState() => _alertTransportState();
}

class _alertTransportState extends State<alertTransport> {
  void setDriver(String id) async {
    QuerySnapshot querySnapshot = await db.collection('drivers').get();
    for (var doc in querySnapshot.docs) {
      if (doc.id == id) {
        selectedDriver = doc;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return AlertDialog(
      scrollable: true,
      title: Text(
        'Добавить транспорт',
        style:
            TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 23),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Название',
              labelStyle: TextStyle(color: black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: black),
              ),
            ),
            style: const TextStyle(color: black),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          DropdownButtonFormField<String>(
            value: dropValue,
            items: items.map(buildMenuItem).toList(),
            dropdownColor: white,
            onChanged: (String? value) {
              dropValue = value;
            },
            onSaved: (value) {
              dropValue = value;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('drivers').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DropdownButtonFormField(
                  dropdownColor: white,
                  items: snapshot.data?.docs.map((document) {
                    return DropdownMenuItem(
                      value: document.id,
                      child: Text(
                        document.get('name'),
                        style: const TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDriver(value!);
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.05,
            child: FloatingActionButton(
              onPressed: () async {
                if (dropValue == null ||
                    dropValue == "" ||
                    nameController.text.isEmpty ||
                    selectedDriver == null) {
                  Toast.show('Заполните все поля');
                  return;
                }

                await db.collection('transports').add({
                  'name': nameController.text,
                  'type': dropValue,
                  'driverName': selectedDriver!.get('name'),
                  'status': 'pickup'
                });
                Navigator.pop(context);
                Toast.show('Транспорт успешно добавлен!');
              },
              backgroundColor: buttonColor,
              child: const Text(
                'Сохранить',
                style: TextStyle(color: white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
