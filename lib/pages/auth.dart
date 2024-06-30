import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_dispatcher/database/auth_service.dart';
import 'package:flutter_dispatcher/global.dart' as globals;
import 'package:toast/toast.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool visibility = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AuthService authService = AuthService();

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: bodyBackground,
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: buttonColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/');
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white))
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
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  Text('транспорта',
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ],
              )
            ],
          )
        ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Авторизация",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(),
                  hintText: 'Email',
                  hintStyle: const TextStyle(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: passController,
                obscureText: !visibility,
                style: const TextStyle(),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    icon: !visibility
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off,
                          ),
                  ),
                  prefixIcon: const Icon(
                    Icons.password,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Пароль',
                  labelStyle: const TextStyle(),
                  hintText: 'Пароль',
                  hintStyle: const TextStyle(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              child: FloatingActionButton(
                backgroundColor: buttonColor,
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passController.text.isEmpty) {
                    Toast.show("Заполните все поля");
                  } else {
                    var user = await authService.signIn(
                        emailController.text, passController.text);
                    if (user == null) {
                      Toast.show("Неправильный Email/Пароль!");
                    } else {
                      if (FirebaseAuth.instance.currentUser != null) {
                        globals.currentUser = await FirebaseFirestore.instance
                            .collection('profiles')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get();
                      }

                      // ignore: use_build_context_synchronously
                      Navigator.popAndPushNamed(context, '/');
                      Toast.show("Вы вошли!");
                    }
                  }
                },
                child: const Text(
                  'Войти',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            InkWell(
              child: const Text(
                'Нет аккаунта? Зарегистрируйтесь!',
                style: TextStyle(fontSize: 14),
              ),
              onTap: () => Navigator.popAndPushNamed(context, '/reg'),
            ),
          ],
        ),
      ),
    );
  }
}
