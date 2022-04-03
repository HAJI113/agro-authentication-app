import 'package:agro/authentication.dart';
import 'package:agro/home.dart';
import 'package:agro/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Register Here....?'),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: SignUp(),
              ),
            ],

//end of the mail column
          ),
        ],
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? name;

  final pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //email

          TextFormField(
            
            decoration: InputDecoration(
              hintText: "Enter Your Email",
            ),

            //validate
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 10,
          ),

          //password

          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter password',
            ),
            //validate
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },

            onSaved: (val) {
              password = val;
            },
          ),
//signup btn
          SizedBox(
            height: 50,
            width: double.infinity,

            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  authenticationHelper()
                      .signUp(email: email!, password: password!)
                      .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => homePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(result
                            //edit style here latter
                            ),
                      ));
                    }
                  });
                }
              },
              child: Text('Sign Up'),

            ),
          ),
          Container(
            child: FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
              },
              
              child:Text('Sign in'),
          ),),
//Btn
        ],
      ),
    );
  }
}
