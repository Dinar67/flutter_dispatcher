import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dispatcher/colors.dart';
import 'package:flutter_dispatcher/database/auth_service.dart';
import 'package:flutter_dispatcher/database/profile_collection.dart';
import 'package:toast/toast.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AuthService authService = AuthService();
  ProfileCollection profileCollection = ProfileCollection();
  bool visibility = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: buttonColor,
        leadingWidth: 250,
        leading: Row(children: [
          const SizedBox(width: 10),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              const Text(
                "Регистрация",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: surnameController,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.face,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    labelText: 'Фамилия',
                    labelStyle: const TextStyle(),
                    hintText: 'Фамилия',
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
                  controller: nameController,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.face,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    labelText: 'Имя',
                    labelStyle: const TextStyle(),
                    hintText: 'Имя',
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
                  controller: patronymicController,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.face,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide()),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    labelText: 'Отчество',
                    labelStyle: const TextStyle(),
                    hintText: 'Отчество',
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
                  controller: phoneController,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    labelText: 'Телефон',
                    labelStyle: const TextStyle(),
                    hintText: 'Телефон',
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
                  controller: emailController,
                  style: const TextStyle(),
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
                    labelText: 'Почта',
                    labelStyle: const TextStyle(),
                    hintText: 'Почта',
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
                    if (surnameController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        patronymicController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passController.text.isEmpty) {
                      Toast.show("Заполните все поля!");
                    } else {
                      var user = await authService.signUp(
                          emailController.text, passController.text);
                      if (user == null) {
                        Toast.show("Проверьте правильность данных!");
                      } else {
                        await profileCollection.addProfile(
                            user.id!,
                            surnameController.text,
                            nameController.text,
                            patronymicController.text,
                            phoneController.text,
                            emailController.text,
                            passController.text,
                            '');
                        Toast.show("Вы успешно зарегистрировались!");
                        Navigator.popAndPushNamed(context, '/');
                      }
                    }
                  },
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'bebasRegular',
                        fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              InkWell(
                child: const Text(
                  'Есть аккаунт? Войти',
                  style: TextStyle(fontFamily: 'bebasRegular', fontSize: 14),
                ),
                onTap: () => Navigator.popAndPushNamed(context, '/auth'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
