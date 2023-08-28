import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_app/components/constants.dart';
import 'package:vibe_app/screens/providers/community_provider.dart';
import 'package:vibe_app/screens/providers/group_provider.dart';
import 'package:vibe_app/widget/community_card.dart';
import 'package:vibe_app/widget/group_card.dart';

class GroupsCommunities extends StatefulWidget {
  const GroupsCommunities({super.key});

  @override
  State<GroupsCommunities> createState() => _GroupsCommunitiesState();
}

class _GroupsCommunitiesState extends State<GroupsCommunities> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: CustomColors().bgColor,
        appBar: AppBar(
          backgroundColor: CustomColors().primaryColor,
          title: Text(
            "Grouops & Communities",
            style: TextStyle(
              color: CustomColors().genericWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Groups",
                  style: TextStyle(
                    color: CustomColors().genericWhite,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Communities",
                  style: TextStyle(
                    color: CustomColors().genericWhite,
                  ),
                ),
              ),
            ],
            indicatorColor: CustomColors().secondaryColor,
            indicatorWeight: 2,
          ),
        ),
        body: Consumer2<GroupProvider, CommunitProvider>(
          builder: (context, groupProvider, communityProvider, _) {
            return RefreshIndicator(
              onRefresh: () async {
                groupProvider.clearAndFetchNewGroup();
                communityProvider.clearAndFetchNewCommunities();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Discover Groups"),
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
                                child: const Text("See all"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Your Groups",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors().primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ...groupProvider.groups.map((group) {
                            return GroupCard(group: group);
                          }),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Discover Commuinities"),
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
                                child: const Text("See all"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Your Communities",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors().primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ...communityProvider.comminities.map(
                            (community) {
                              return CommunityCard(community: community);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
