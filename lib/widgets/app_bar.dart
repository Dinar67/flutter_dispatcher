import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: buttonColor,
    actions: [
      IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
          icon:
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white))
    ],
    iconTheme: const IconThemeData(color: Colors.white),
    leadingWidth: 250,
    leading: Row(children: [
      const SizedBox(
        width: 10,
      ),
      Row(
        children: [
          SizedBox(
            child: Image.asset(
              'assets/images/logo.png', // Установите высоту
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 5),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Аренда',
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 16)),
              Text('транспорта',
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          )
        ],
      )
    ]),
  );
}
