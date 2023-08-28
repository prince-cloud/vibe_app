import 'package:flutter/material.dart';
import 'package:vibe_app/screens/models/user.dart';

class UserCard extends StatefulWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          // dense: true,
          horizontalTitleGap: 10,
          leading: widget.user.profilePicture.isNotEmpty
              ? CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    widget.user.profilePicture,
                  ),
                )
              : const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(
                    'assets/icons/group_icon.jpeg',
                  ),
                ),
          title: Text(
            widget.user.username,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text("${widget.user.totalFollowers} followers"),
          trailing: GestureDetector(
            child: const Text(
              "Follow",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(
          thickness: 0.5,
        )
      ],
    );
  }
}
