import 'package:agro/authentication.dart';
import 'package:agro/home.dart';
import 'package:agro/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
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
              Text('Login Here....?'),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Signin(),
              ),
            ],

//end of the mail column
          ),
        ],
      ),
    );
  }
}

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;


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
          //signin btn

           SizedBox(
            height: 50,
            width: double.infinity,

            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  authenticationHelper()
                      .signIn(email: email!, password: password!)
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
              child: Text('Sign In'),
            ),
          ),

          Container(
            child: FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
              },
              
              child:Text('Sign Up'),
          ),),
//Btn


        ],
      ),
    );
  }
}
