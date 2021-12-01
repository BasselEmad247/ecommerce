import 'dart:developer';

import 'package:ecommerce/bloc/ecommerce_cubit.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/screens/cart.dart';
import 'package:ecommerce/screens/signup.dart';
import 'package:ecommerce/services/http.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static User? loggedInUser;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Http http = Http();
  final loginFormKey = GlobalKey<FormState>();
  bool obscureText = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: loginFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset("assets/logo.jpg"),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 350,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required!";
                  } else if (!EmailValidator.validate(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 350,
              child: TextFormField(
                controller: passwordController,
                obscureText: obscureText,
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  border: OutlineInputBorder(),
                  hintText: "Password",
                ),
                validator: (value) {
                  String pattern =
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                  RegExp regExp = new RegExp(pattern);
                  if (value == null || value.isEmpty) {
                    return "This field is required!";
                  } else if (regExp.hasMatch(value) == false) {
                    return "Password must contain 1 uppercase - 1 lowercase - 1 numeric number - 1 special character (common allow characters ( ! @ # \$ & * ~ ))";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    primary: Colors.red,
                    minimumSize: Size(200, 40)),
                onPressed: () async {
                  if (loginFormKey.currentState!.validate()) {
                    final tokenResponse = await http.loginStatus(emailController.text, passwordController.text);
                    if(tokenResponse == 301)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Server error!", textAlign: TextAlign.center,)),
                        );
                      }
                    else if(tokenResponse == 401)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Wrong email or password!", textAlign: TextAlign.center,)),
                      );
                    }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Logged in Successfully!", textAlign: TextAlign.center,)),
                        );
                        final token = await http.loginToken(emailController.text, passwordController.text);
                        Login.loggedInUser = await http.getUserDetails(token);
                        EcommerceCubit cubit = EcommerceCubit.get(context);
                        cubit.screens[2] = Cart(Login.loggedInUser);
                        cubit.changeIndex(2);
                      }
                  }
                },
                child: const Text("Login"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                log("SignUp pressed!");
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Signup();
                }));
              },
              child: Text("Go SignUp"),
            )
          ],
        ),
      ),
    );
  }
}
