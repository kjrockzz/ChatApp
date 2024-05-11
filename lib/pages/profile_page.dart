import 'package:flutter/material.dart';
import 'package:proj1/pages/home_page.dart';
import 'package:proj1/pages/search_page.dart';

import '../helper/helper_func.dart';
import '../service/auth_service.dart';
import '../widgets/widgets.dart';
import 'auth/Login_page.dart';
class ProfilePage extends StatefulWidget {
  String userName = "";
  String email = "";
  ProfilePage({Key? key,required this.email,required this.userName}): super(key: key) ;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  AuthService authService = AuthService();

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
                fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.grey[700],
              ),
              const SizedBox(height: 15),
              Text(
                widget.userName,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Divider(
                height: 2,
              ),
              ListTile(
                onTap: () async {
                  nextScreenReplace(context, HomePage());
                },
                
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                leading: const Icon(Icons.group),
                title: const Text(
                  "groups",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {
                 
                },
                selectedColor: Theme.of(context).primaryColor,
                selected: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                leading: const Icon(Icons.group),
                title: const Text(
                  "profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout"),
                          content:
                              const Text("Are u sure you want to Logout??"),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.cancel, color: Colors.red)),
                            IconButton(
                                onPressed: () async {
                                  await authService.signOut();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                      (route) => false);
                                },
                                icon: Icon(Icons.done, color: Colors.green))
                          ],
                        );
                      });
                },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                leading: const Icon(Icons.group),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding:const EdgeInsets.symmetric(horizontal: 40,vertical:170),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.account_circle,size:200,color: Colors.grey[700]),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Full Name : ", style:TextStyle(fontSize: 17)),
                  Text(widget.userName, style:const TextStyle(fontSize: 17))
                ],
              ),
               const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Email : ", style:TextStyle(fontSize: 17)),
                  Text(widget.email, style:const TextStyle(fontSize: 17))
                ],
              ),
            ],
          ),
        
        )
        );
  }
} 