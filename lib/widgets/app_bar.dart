import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_svg/svg.dart';

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
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              color: white, // Установите высоту
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.06,
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
