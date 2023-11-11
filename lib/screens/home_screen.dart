import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant/reusable_widgets/reusable_widgets.dart';
import 'package:plant/screens/scanning_screen.dart';
import 'package:plant/screens/signin_screen.dart';
import 'package:plant/screens/scanning_screen.dart';
import 'package:plant/screens/chatBot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

          alignment: Alignment(0, 0),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(2.0),

                child: Column(
                    children: <Widget>[
                      logoWidget("assets/images/logo1.png"),
                      SizedBox(
                        height: 30,
                      ),

                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              padding:
                              MaterialStateProperty.all(const EdgeInsets.all(20)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => scanning_screen()));
                            },
                            child: Text('Scan Your Leaf'.tr(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              padding:
                              MaterialStateProperty.all(const EdgeInsets.all(20)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                              ),),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ChatBot()));
                            },
                            child: Text("ChatBot".tr(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),)
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      SizedBox(
                        width: 200,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                                ),),
                              onPressed: (){
                                FirebaseAuth.instance.signOut().then((value) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => SignInScreen()));
                                });
                              },
                              child:  Text("LOGOUT".tr(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),)
                          )
                      ),
                    ]
                ),
              )
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            Icons.language_outlined,
            size: 50,
        ),
        backgroundColor: Colors.green,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => LanguagePage())),
      ),
    );
  }
}
class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language".tr()),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 200.0),
          width: 500,
          child: Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    backgroundColor: Colors.green,// Set the minimum size here
                  ),
                  onPressed: (){
                    setState(() {
                      context.setLocale(Locale("en", "EN"));
                });
              }, child:  Text("English".tr(), style: TextStyle(fontSize: 20),)),
              SizedBox(height: 5),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    backgroundColor: Colors.green,// Set the minimum size here
                  ),
                  onPressed: (){
                    setState(() {
                      context.setLocale(Locale("ur", "UR"));
                    });
                  }, child:  Text("Urdu".tr(), style: TextStyle(fontSize: 20),)),

              /*SizedBox(height: 5),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    backgroundColor: Colors.green,// Set the minimum size here
                  ),
                  onPressed: (){
                    setState(() {
                      context.setLocale(Locale("sn", "SN"));
                    });
                  }, child:  Text("Sindhi".tr(), style: TextStyle(fontSize: 30),)),*/
            ],
          ),
        ),
      ),
    );
  }
}
