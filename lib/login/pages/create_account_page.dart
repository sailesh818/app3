import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/home/page/home_page.dart';
import 'package:flutter_application_3/login/widgets/custom_button.dart';
import 'package:flutter_application_3/login/widgets/customtextfield_widget.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  
  bool loading = false;
  bool hidePassword = false;
  bool hideconfirmPassword = false;

  Future<void> createAccount() async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    String confirmpassword = confirmpasswordcontroller.text.trim();

    if(email.isEmpty || password.isEmpty || confirmpassword.isEmpty){
      showMessage(
        "Please fill all fields",
      );
      return;
    }
    if(password != confirmpassword){
      showMessage(
        "Passwords do not match",
      );
      return;
    }
    if(password.length < 6){
      showMessage(
        "Passwords do not match",
      );
      return;
    }

    try{
      setState(() {
        loading = true;
      });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      if(!mounted) return;
      
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

    } on FirebaseAuthException catch(e){
      String error = "Something went wrong";

      if(e.code == "email-already-in-use"){
        error = "Emaill already registered";
      }
      else if(e.code == "invalid-email"){
        error = "Invalid email";
      }
      if(e.code == "weak-password"){
        error = "Passwords too weak";
      }
      showMessage(error);
    }

    finally{
      setState(() {
        loading = false;
      });
    }


  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }
  

  void showMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CustomtextfieldWidget(
              controller: emailcontroller, 
              label: "Enter your email", 
              icon: Icons.mail
            ),
            SizedBox(
              height: 20,
            ),
            CustomtextfieldWidget(
              controller: passwordcontroller, 
              label: "Enter your password", 
              icon: Icons.lock,
              obscureText: hidePassword,
              showPasswordIcon: true,
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
            ),
            SizedBox(height: 20,),
            CustomtextfieldWidget(
              controller: confirmpasswordcontroller, 
              label: "Confirm your password", 
              icon: Icons.lock,
              obscureText: hideconfirmPassword,
              showPasswordIcon: true,
              onPressed: (){
                setState(() {
                  hideconfirmPassword = !hideconfirmPassword;
                });
              }
            ),
            SizedBox(height: 20,),
            CustomButton(
              onPressed: createAccount,
              loading: loading, 
              text: "Create Account"
            )
          ],
        ),
      ),
    );
  }
}

