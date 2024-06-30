import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:flutter_dispatcher/global.dart' as globals;

final FirebaseFirestore db = FirebaseFirestore.instance;

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
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
            "Выбрать статус",
            style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: bodyBackground,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('status').snapshots(),
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
                    if (widget.doc!['name'] == 'boarding')
                      SvgPicture.asset(
                        'assets/images/state_boarding.svg',
                        color: black,
                      ),
                    if (widget.doc!['name'] == 'delivery')
                      SvgPicture.asset(
                        'assets/images/state_delivery.svg',
                        color: black,
                      ),
                    if (widget.doc!['name'] == 'load')
                      SvgPicture.asset(
                        'assets/images/state_load.svg',
                        color: black,
                      ),
                    if (widget.doc!['name'] == 'parking')
                      SvgPicture.asset(
                        'assets/images/state_parking.svg',
                        color: black,
                      ),
                    if (widget.doc!['name'] == 'pickup')
                      SvgPicture.asset(
                        'assets/images/state_pickup.svg',
                        color: black,
                      ),
                    if (widget.doc!['name'] == 'repair')
                      SvgPicture.asset(
                        'assets/images/state_repair.svg',
                        color: black,
                      ),
                    if (widget.doc!['name'] == 'unboarding')
                      SvgPicture.asset(
                        'assets/images/state_unboarding.svg',
                        color: black,
                      ),
                    SizedBox(width: 15),
                    Text(
                      widget.doc!['seeName'],
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: FloatingActionButton(
                    onPressed: () async {
                      await globals.selectedTransport!.reference
                          .update({'status': widget.doc!['name']});
                      Toast.show('Статус успешно изменен!');
                      Navigator.popAndPushNamed(context, '/');
                    },
                    backgroundColor: buttonColor,
                    child: Text(
                      'Выбрать',
                      style:
                          TextStyle(color: white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
    ;
  }
}
