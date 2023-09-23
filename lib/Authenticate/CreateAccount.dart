import 'package:chat_v2/Authenticate/Methods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Screens/HomeScreen.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cnfrmpassword = TextEditingController();

  bool isLoading = false;
  bool passwordObscured = true;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

//firstnamefield
    final Name = TextFormField(
      autofocus: false,
      controller: _name,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        _name.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    //email
    final emailField = TextFormField(
      autofocus: false,
      controller: _email,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        _email.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
//password
    final passwordField = TextFormField(
      autofocus: false,
      controller: _password,
      obscureText: passwordObscured,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        _password.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(onPressed: () {
            setState(() {
              passwordObscured = !passwordObscured;
            });
          },
            icon: Icon(
              passwordObscured ?
              Icons.visibility_off : Icons.visibility,),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
//Confirm
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: _cnfrmpassword,
      obscureText: passwordObscured,
      validator: (value) {
        if (_cnfrmpassword.text !=
            _password.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        _cnfrmpassword.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(onPressed: () {
            setState(() {
              passwordObscured = !passwordObscured;
            });
          },
            icon: Icon(
              passwordObscured ?
              Icons.visibility_off : Icons.visibility,),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading
          ? Center(
        child: Container(
          height: size.height,
          width: size.height,
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child:
                        Image.asset("assets/logo.png",
                            fit: BoxFit.contain)),

                    SizedBox(height: 40),
                    Container(
                      width: size.width / 1.1,
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width / 1.1,
                      child: Text(
                        "Create Account to Contiue!",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 25),
                    Name,

                    SizedBox(height: 20),
                    emailField,

                    SizedBox(height: 20),
                    passwordField,

                    SizedBox(height: 20),
                    confirmPasswordField,

                    SizedBox(height: 20),
                    customButton(size),

                    SizedBox(height: 15),
                  ],
                )
            ),
          ),
        ),

      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          ((e) {
            Fluttertoast.showToast(msg: e!.message);
          });
          createAccount(_name.text, _email.text, _password.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = true;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
              Fluttertoast.showToast(msg: "Account created successfully :) ");
              setState(() {
                isLoading = false;
              });
            }
          });
        }
      },

      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.redAccent,
          ),
          alignment: Alignment.center,
          child: Text(
            "Sign-IN",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}