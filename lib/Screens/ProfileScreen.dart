import 'package:chat_v2/Authenticate/LoginScreen.dart';
import 'package:chat_v2/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          //currentIndex: currentIndex,
          onTap: (index){},
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.redAccent),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.redAccent),
              label: 'Profile',
            ),
          ],
        ),
        appBar:AppBar(title: Text("Profile"),
          centerTitle:true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.red),

            onPressed: () {
              Navigator.of(context).pop();
              //logout(context);
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Welcome",
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50,),
                SizedBox(
                  height: 100,
                  child: Image.asset("assets/profile.png", fit: BoxFit.contain),
                ),
                SizedBox(height: 50,),

                SizedBox(height: 40,),
                Text("Username: ${loggedInUser.Name}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 15,),
                Text("Email: ${loggedInUser.email}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 50,
                ),
                ActionChip(
                    label: Text("Logout"),
                    onPressed: () {
                      logout(context);
                    }),
              ],
            ),
          ),
        )
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

}