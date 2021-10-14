import 'package:ecommerce/services/http.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
            Image.asset("images/logo.jpg"),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 350,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email"
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required!";
                  }
                  else if(EmailValidator.validate(value))
                    {
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
                    onPressed: (){
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
                  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                  RegExp regExp = new RegExp(pattern);
                  if (value == null || value.isEmpty) {
                    return "This field is required!";
                  }
                  else if(regExp.hasMatch(value) == false)
                    {
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
                    minimumSize: Size(200, 40)
                ),
                onPressed: () {
                  if (loginFormKey.currentState!.validate()) {
                    http.login(emailController.text, passwordController.text);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                  }
                },
                child: const Text("Login"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (){
                print("SignUp pressed!");
              },
              child: Text("Go SignUp"),
            )
          ],
        ),
      ),
    );
  }
}
