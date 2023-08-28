import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:vibe_app/components/constants.dart';
import 'package:vibe_app/screens/create_post.dart';
import 'package:vibe_app/screens/providers/auth_provider.dart';
import 'package:vibe_app/screens/providers/post_provider.dart';
import 'package:vibe_app/widget/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(
      listen: false,
      context,
    );
    return Scaffold(
      backgroundColor: CustomColors().bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: CustomColors().genericWhite,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatePost(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  authProvider.user!.profilePicture.isEmpty
                      ? const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpeg'),
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            authProvider.user!.profilePicture,
                          ),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "What's vibing ...",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                "ViBE",
                style: TextStyle(
                  color: CustomColors().primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<PostProvider>(builder: (context, postProvider, _) {
        return RefreshIndicator(
          onRefresh: () async {
            postProvider.clearAndFetchNewPost();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                if (postProvider.posts.isNotEmpty)
                  ...postProvider.posts.map(
                    (post) {
                      return PostCard(post: post);
                    },
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
