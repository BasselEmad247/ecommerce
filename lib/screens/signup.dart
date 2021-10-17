import 'package:ecommerce/services/http.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final Http http = Http();
  final signupFormKey = GlobalKey<FormState>();
  bool obscureText = true;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Signup"),
        backgroundColor: Colors.red,),
      body: SafeArea(
        child: Form(
          key: signupFormKey,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Image.asset("images/logo.jpg"),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 350,
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name"
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required!";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),Container(
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
                    else if(!EmailValidator.validate(value))
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
                  onPressed: () async {
                    if (signupFormKey.currentState!.validate()) {
                      final response = await http.register(nameController.text, emailController.text, passwordController.text);
                      if(response == 201) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Registered Successfully!", textAlign: TextAlign.center,)),
                        );
                        Navigator.pop(context);
                      }
                      else if(response == 422)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("The email has already been taken!", textAlign: TextAlign.center,)),
                          );
                        }
                      else if(response == 301)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Server error!", textAlign: TextAlign.center,)),
                        );
                      }
                    }
                  },
                  child: const Text("Signup"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  print("Login pressed!");
                  Navigator.pop(context);
                },
                child: Text("Have an account ?\nGo Login", textAlign: TextAlign.center,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
