import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_dispatcher/widgets/app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: bodyBackground,
      appBar: appBar(context),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'НАШИ КОТНТАКТЫ',
              style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
              "Главный диспетчер:\n Фатхуллин Марс  8(800) 555 35-35",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            const Center(
              child: Text(
                textAlign: TextAlign.center,
                'ПРОЩЕ ПОЗВОНИТЬ, ЧЕМ У КОГО-ТО АРЕНДОВАТЬ!',
                style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
