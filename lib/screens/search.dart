import 'package:flutter/material.dart';
import 'package:vibe_app/components/constants.dart';
import 'package:vibe_app/screens/api_services/authentication.dart';
import 'package:vibe_app/screens/api_services/base.dart';
import 'package:vibe_app/screens/api_services/groups_comunity.dart';
import 'package:vibe_app/screens/api_services/post_services.dart';
import 'package:vibe_app/screens/models/groups.dart';
import 'package:vibe_app/screens/models/post.dart';
import 'package:vibe_app/screens/models/user.dart';
import 'package:vibe_app/widget/custom_textfield.dart';
import 'package:vibe_app/widget/error_dialogue.dart';
import 'package:vibe_app/widget/group_card.dart';
import 'package:vibe_app/widget/loading_dialogue.dart';
import 'package:vibe_app/widget/no_results_found.dart';
import 'package:vibe_app/widget/post_card.dart';
import 'package:vibe_app/widget/search_illustration.dart';
import 'package:vibe_app/widget/user_card.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PostModel> posts = [];
  List<User> users = [];
  List<GroupModel> groups = [];
  String searchKeyWord = '';
  startSearch({required String searchValue}) async {
    final postResponse = await PostServices().getPostWithSearchTerm(
      searchTerm: searchValue,
    );
    final userResponse = await AuthenticationService().getUserWithSearchTerm(
      searchTerm: searchValue,
    );
    final groupResponse = await GroupCommunityServices().getGroupWithSearchTerm(
      searchTerm: searchValue,
    );

    setState(() {
      posts = postResponse;
      users = userResponse;
      groups = groupResponse;
      searchKeyWord = searchValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().bgColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: CustomColors().primaryColor,
        title: CustomTextField(
          textInputAction: TextInputAction.go,
          onFieldSubmitted: (value) async {
            if (value.isEmpty) {
              ErrorDialogue.show(context, "Please enter a search keyword");
              return;
            }
            toggleIsLoading();
            await startSearch(searchValue: value);
            toggleIsLoading();
          },
          decoration: InputDecoration(
            isDense: true,
            hintText: "Search",
            hintStyle: TextStyle(
              color: CustomColors().textColor,
              fontWeight: FontWeight.w300,
            ),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                right: 13,
                left: 5,
              ),
              child: Icon(
                Icons.search,
                color: CustomColors().textColor,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          _tabSection(context),
        ],
      ),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          Container(
            color: CustomColors().bgColor,
            child: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Posts",
                    style: TextStyle(
                      color: CustomColors().primaryColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Users",
                    style: TextStyle(
                      color: CustomColors().primaryColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Groups",
                    style: TextStyle(
                      color: CustomColors().primaryColor,
                    ),
                  ),
                ),
              ],
              indicatorColor: CustomColors().secondaryColor,
              indicatorWeight: 2,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.98,
            width: MediaQuery.of(context).size.width * 0.85,
            child: TabBarView(
              // controller: tabBarController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      if (searchKeyWord.isEmpty)
                        const SearchIllustration(
                          text:
                              "Searh with made easy\nSearch with your keyword",
                        ),
                      if (searchKeyWord.isNotEmpty & posts.isEmpty)
                        NoResultsFound(
                          searchKeyWord: searchKeyWord,
                          category: "Post",
                        ),
                      ...posts.map(
                        (post) {
                          return PostCard(post: post);
                        },
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      if (searchKeyWord.isEmpty)
                        const SearchIllustration(
                          text:
                              "Searh with made easy\nSearch with your keyword",
                        ),
                      if (searchKeyWord.isNotEmpty & users.isEmpty)
                        NoResultsFound(
                          searchKeyWord: searchKeyWord,
                          category: "User",
                        ),
                      ...users.map(
                        (user) {
                          return UserCard(user: user);
                        },
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      if (searchKeyWord.isEmpty)
                        const SearchIllustration(
                          text:
                              "Searh with made easy\nSearch with your keyword",
                        ),
                      if (searchKeyWord.isNotEmpty & groups.isEmpty)
                        NoResultsFound(
                          searchKeyWord: searchKeyWord,
                          category: "Group",
                        ),
                      ...groups.map(
                        (group) {
                          return GroupCard(group: group);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isLoading = false;
  toggleIsLoading() {
    setState(
      () {
        isLoading = !isLoading;
        isLoading
            ? showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => WillPopScope(
                  onWillPop: () async {
                    setState(() {
                      isLoading = !isLoading;
                    });
                    return true;
                  },
                  child: const LoadingDialog(),
                ),
              )
            : Navigator.of(context).pop();
      },
    );
  }
}
