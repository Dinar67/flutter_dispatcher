import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:flutter_dispatcher/global.dart' as globals;

final FirebaseFirestore db = FirebaseFirestore.instance;

class DriverPage extends StatefulWidget {
  const DriverPage({super.key});

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        floatingActionButton: globals.currentUser!.get('role') == 'admin'
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const alertDriver();
                      });
                },
                backgroundColor: buttonColor,
                child: const Icon(
                  Icons.add,
                  color: white,
                ),
              )
            : const SizedBox(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: black,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
          ),
          backgroundColor: white,
          centerTitle: true,
          title: const Text(
            "Выбрать водителя",
            style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: bodyBackground,
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('drivers').snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return myCard(doc: snapshot.data!.docs[index]);
                  });
            }));
  }
}

class myCard extends StatefulWidget {
  final DocumentSnapshot? doc;

  const myCard({super.key, required this.doc});

  @override
  State<myCard> createState() => _myCardState();
}

class _myCardState extends State<myCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
          color: white,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/account_circle.svg'),
                    SizedBox(width: 15),
                    Text(
                      widget.doc!['name'],
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    globals.currentUser!.get('role') == 'admin'
                        ? IconButton(
                            onPressed: () async {
                              await widget.doc!.reference.delete();
                              Toast.show('Водитель успешно удален!');
                            },
                            icon: Icon(
                              Icons.delete,
                            ))
                        : const SizedBox(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: FloatingActionButton(
                        onPressed: () async {
                          await globals.selectedTransport!.reference.update({
                            'driverName': widget.doc!['name'],
                          });
                          Toast.show('Водятел успешно выбран!');
                          Navigator.popAndPushNamed(context, '/');
                        },
                        backgroundColor: buttonColor,
                        child: const Text(
                          'Выбрать',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
    ;
  }
}

class alertDriver extends StatefulWidget {
  const alertDriver({super.key});

  @override
  State<alertDriver> createState() => _alertDriverState();
}

class _alertDriverState extends State<alertDriver> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    return AlertDialog(
      scrollable: true,
      title: Text(
        'Добавить водителя',
        style:
            TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 23),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Имя',
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
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.05,
            child: FloatingActionButton(
              onPressed: () async {
                if (nameController.text.isEmpty) {
                  Toast.show('Заполните имя');
                  return;
                }

                await db.collection('drivers').add({
                  'name': nameController.text,
                });
                Navigator.pop(context);
                Toast.show('Водитель успешно добавлен!');
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
