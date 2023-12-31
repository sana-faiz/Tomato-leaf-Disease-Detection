import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant/screens/home_screen.dart';
import 'package:plant/utils/color_utils.dart';
import 'package:plant/reusable_widgets/reusable_widgets.dart';
import 'package:plant/screens/signup_screen.dart';
import 'package:plant/screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: LinearGradient(colors: [
            Colors.purple ,Colors.orange
            /*hexStringToColor("CB2893"),
        hexStringToColor("9546C4"),
        hexStringToColor("5E61F4")*/
          ],
              begin:Alignment.topCenter, end: Alignment.bottomCenter
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget("assets/images/logo1.png"),
                  SizedBox(
                    height: 30,
                  ),
                  reusableTextField("Enter Email".tr(), Icons.person_outline, false, _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password".tr(), Icons.lock_outline, true, _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  singInSignUpButton(context, true, () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                        .then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                   }),
                  signUpOption()
                ],
              ),
            ),
          )
      ),
    );
  }
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text("Don't have account?".tr(),
            style: TextStyle(color:Colors.white70)),
        GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
        )
      ],
    );
  }
}

