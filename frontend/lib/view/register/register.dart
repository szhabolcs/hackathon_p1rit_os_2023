import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  late String email;
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView (
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 200,),
              const Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(22, 66, 118, 1)
                ),
              ),
              const SizedBox(height: 130,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(210, 220, 232, 1)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(210, 220, 232, 1)),
                                ),
                                hintText: 'Your username',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(192, 206, 222, 1)
                                ),
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(132, 151, 173, 1)
                                )
                            ),
                            onSaved: (String? value) {
                              username = value ?? "";
                            },
                            validator: (String? value) {

                              if (value == null || value.isEmpty) {
                                return "This field is mandatory";
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(210, 220, 232, 1)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(210, 220, 232, 1)),
                                ),
                                hintText: 'example@gmail.com',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(192, 206, 222, 1)
                                ),
                                labelText: 'E-mail',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(132, 151, 173, 1)
                                )
                            ),
                            onSaved: (String? value) {
                              email = value ?? "";
                            },
                            validator: (String? value) {

                              RegExp regex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                              if (value == null || value.isEmpty) {
                                return "This field is mandatory";
                              }

                              if (!regex.hasMatch(value)) {
                                return "Invalid email!";
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(210, 220, 232, 1)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(210, 220, 232, 1)),
                                ),
                                hintText: '***',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(192, 206, 222, 1)
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(132, 151, 173, 1)
                                )
                            ),
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            onSaved: (String? value) {
                              password = value ?? "";
                            },
                            validator: (String? value) {

                              RegExp regex =
                              RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                              if (value == null || value.isEmpty) {
                                return "This field is mandatory";
                              }

                              if (!regex.hasMatch(value)) {
                                return 'At least one big character, one small, one number, one special and at least 8 characters';

                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 100,),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: const Color.fromRGBO(68, 153, 255, 1),
                                minimumSize: const Size.fromHeight(50),
                              ),

                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                }
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
