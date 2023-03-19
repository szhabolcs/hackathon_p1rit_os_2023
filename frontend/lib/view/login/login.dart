import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_calls.dart';
import 'package:frontend/view/register/register.dart';

import '../dashboard/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView (
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 155,),
              const Text(
                "Login",
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
                                hintText: '****',
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
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: const Color.fromRGBO(68, 153, 255, 1)
                              ),

                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (await ApiCalls().login(email, password))
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashBoard()));
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 100,),
                    const Text("Don't have an account yet?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Color.fromRGBO(22, 66, 118, 1)
                        ),
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
