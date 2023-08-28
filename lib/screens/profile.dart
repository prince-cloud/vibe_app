import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_app/components/constants.dart';
import 'package:vibe_app/screens/api_services/authentication.dart';
import 'package:vibe_app/screens/authentication/login.dart';
import 'package:vibe_app/screens/models/profile.dart';
import 'package:vibe_app/screens/providers/auth_provider.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileModel? profile;
  getUserProfile() async {
    final response = await AuthenticationService().getProfile();
    setState(() {
      profile = response;
    });
  }

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().bgColor,
      appBar: AppBar(
        backgroundColor: CustomColors().primaryColor,
        title: Text(
          "Profile",
          style: TextStyle(
            color: CustomColors().genericWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              AuthProvider authProvider = Provider.of<AuthProvider>(
                listen: false,
                context,
              );
              authProvider.logOut();
              Navigator.popUntil(
                context,
                ModalRoute.withName('/'),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: profile == null
          ? const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      profile!.profilePicture.isEmpty
                          ? const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/profile.jpeg'),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                profile!.profilePicture,
                              ),
                            ),
                      Column(
                        children: [
                          Text(
                            profile!.totalPost.toString(),
                            style: TextStyle(
                              color: CustomColors().primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Post",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            profile!.totalFollowers.toString(),
                            style: TextStyle(
                              color: CustomColors().primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Followers",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            profile!.tottalFollowing.toString(),
                            style: TextStyle(
                              color: CustomColors().primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Following",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile!.fullName,
                            style: TextStyle(
                              color: CustomColors().primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            " ${profile!.username}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 1,
                            color: CustomColors().lightPrimaryColor,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 14,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Profile")
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    profile!.about,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _tabSection(context),
                ],
              ),
            ),
    );
  }

  // late TabController tabBarController;

  // void _handleTabChange() {
  //   setState(() {
  //     tabIndex = tabBarController.index;
  //   });
  // }

  // assingTabController() {
  //   setState(() {
  //     tabBarController = TabController(length: 2, vsync: this);
  //   });
  //   tabBarController.addListener(_handleTabChange);
  // }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                    "Media",
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
            height: MediaQuery.of(context).size.height * 0.58,
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
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColors().genericWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Column(
                          children: [
                            const ListTile(
                              // dense: true,
                              horizontalTitleGap: 0,
                              leading: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.red,
                              ),
                              title: Text("Ovawatch"),
                              subtitle: Text("12 Min Ago"),
                              trailing: Icon(Icons.menu),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 15,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Nice food, this is my favorite food ever !!!",
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset("assets/images/food.JPG"),
                                  ],
                                )),
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: SizedBox(
                                width: 300,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          width: 1,
                                          color: CustomColors().textColor,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 8,
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.recommend),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text("450K")
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          width: 1,
                                          color: CustomColors().textColor,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 8,
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.chat),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text("80")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
