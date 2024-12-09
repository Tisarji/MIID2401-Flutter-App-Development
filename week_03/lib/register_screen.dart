import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const url =
      'data:image/jpeg;base64,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';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final email_text_control = TextEditingController();
  final password_text_control = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  // String error_text = 'No Error';
  final error_text_control = TextEditingController();
  final from_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: from_key,
        child: Container(
            margin: EdgeInsets.all(28),
            width: double.infinity,
            child: Column(
              children: [
                Stack(children: [
                  Image.network(
                    RegisterScreen.url,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Sign Up Account',
                        style: TextStyle(color: Colors.white, fontSize: 20
                          , fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.person, size: 100)
                    ],
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: email_text_control,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)))),
                ),
                SizedBox(
                  height: 20,
                ),
                // Text(error_text, style: TextStyle(color: Colors.red)),
                TextFormField(
                  validator: EmailValidator(errorText: 'Please Input Email'),
                  controller: email_text_control,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: passwordValidator,
                  controller: password_text_control,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: passwordValidator,
                  controller: password_text_control,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)))),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      from_key.currentState?.validate();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
              ],
            )));
  }
}
