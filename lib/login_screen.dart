import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  final _passController = TextEditingController();

  String verificationIdReceived = '';
  bool otpcodevisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 36,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: "Phone Number"),
              controller: _phoneController,
            ),
            SizedBox(
              height: 16,
            ),
            Visibility(
              visible: otpcodevisible,
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Password"),
                controller: _passController,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(otpcodevisible ? "Login" : "verify"),
                onPressed: () {
                  FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: _phoneController.text,
                      verificationCompleted: (PhoneAuthCredential credential) {
                        FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) => print("logged in successful"));
                      },
                      verificationFailed: (FirebaseAuthException exception) {
                        print("verification failed");
                        print(exception.message);
                      },
                      codeSent: (String verificationid, int? resendtoken) {
                        verificationIdReceived = verificationid;
                        otpcodevisible = true;
                        setState(() {});
                      },
                      codeAutoRetrievalTimeout: (String verificationid) {});
                  //code for sign in
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
