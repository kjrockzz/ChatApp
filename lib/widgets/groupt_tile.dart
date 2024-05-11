import 'package:flutter/material.dart';
import 'package:proj1/pages/chat_page.dart';
import 'package:proj1/widgets/widgets.dart';

class GroupTile extends StatefulWidget {
  final String userName, groupId, groupName;
  const GroupTile(
      {Key? key,
      required this.userName,
      required this.groupId,
      required this.groupName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context,  chatPage(groupId: widget.groupId, groupName: widget.groupName, userName: widget.userName));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
              color: Theme.of(context).primaryColorLight,
              strokeAlign: BorderSide.strokeAlignInside),
        )),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          title: Text(
            widget.groupName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "join the convo as ${widget.userName}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
