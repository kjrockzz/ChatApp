import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj1/pages/auth/Login_page.dart';
import 'package:proj1/pages/home_page.dart';
import 'package:proj1/service/auth_service.dart';
import 'package:proj1/service/database_service.dart';
import 'package:proj1/widgets/widgets.dart';

class GroupInfo extends StatefulWidget {
  final String groupId, groupName, adminName,userName;
  const GroupInfo(
      {Key? key,
      required this.groupId,
      required this.adminName,
      required this.groupName,required this.userName})
      : super(key: key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  Stream? members;
  AuthService authService = AuthService();
  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers() async {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((value) {
      setState(() {
        members = value;
      });
    });
  }



  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getID(String r) {
    return r.substring(0, r.indexOf("_"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Group Info"),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Exit"),
                          content: const Text(
                              "Are you sure you want to exit the group??"),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.cancel, color: Colors.red)),
                            IconButton(
                                onPressed: () async {
                                  DatabaseService(
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .toggleGroupJoin(
                                          widget.groupId,
                                          getName(widget.userName),
                                          widget.groupName)
                                      .whenComplete(() {
                                    nextScreenReplace(
                                        context, const HomePage());
                                  });
                                },
                                icon: Icon(Icons.done, color: Colors.green))
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        widget.groupName.substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Group Name : ${widget.groupName}",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text("Admin : ${getName(widget.adminName)}")
                      ],
                    )
                  ],
                ),
              ),
              memberList(),
            ],
          ),
        ));
  }

  memberList() {
    return StreamBuilder(
        stream: members,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['members'] != null) {
              if (snapshot.data['members'].length != 0) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data['members'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            getName(snapshot.data['members'][index])
                                .substring(0, 1)
                                .toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        title: Text(getName(snapshot.data['members'][index])),
                        subtitle: Text(getID(snapshot.data['members'][index])),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("no member"),
                );
              }
            } else {
              return Center(
                child: Text("no member"),
              );
            }
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ));
          }
        });
  }
}
