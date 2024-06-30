import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_dispatcher/widgets/app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
              'О НАШЕЙ КОМАПНИИ',
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
              "Компания по аренде транспорта предлагает широкий спектр услуг для физических и юридических лиц. Она специализируется на аренде автомобилей без экипажа, что выгодно для компаний, так как позволяет уменьшить налогооблагаемую базу за счет возмещения затрат на топливо, ремонт, страхование и другие расходы. Договор аренды автомобиля между компанией и клиентом регламентирует условия аренды, включая сумму арендной платы, которая может быть изменена только с заключением дополнительного соглашения.",
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'О ДОГОВОРЕ',
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
              'В договоре аренды автомобиля также оговариваются условия использования автомобиля, включая запрет на буксировку транспортных средств, езду с прицепом или по бездорожью, участие в спортивных соревнованиях, обучение вождению и коммерческую перевозку пассажиров и грузов без специального договора. Арендатор обязан нести все расходы, связанные с эксплуатацией автомобиля, включая оплату горюче-смазочных материалов, мойки, парковки/стоянки и других расходов.',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'НАША ЦЕЛЬ',
              style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              // ignore: prefer_interpolation_to_compose_strings
              'Наша цель - не оставить вас без транспорта!',
            ),
            const SizedBox(height: 30),
            Center(
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: bodyBackground),
                onPressed: () async {
                  final Uri url = Uri.parse(
                      'https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUN0YDQuNC6INGA0L7Quw%3D%3D');
                  await launchUrl(url);
                },
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  color: buttonColor,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
