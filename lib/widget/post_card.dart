import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:vibe_app/components/constants.dart';
import 'package:vibe_app/screens/models/post.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors().genericWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: [
          ListTile(
            // dense: true,
            horizontalTitleGap: 0,
            leading: widget.post.userAccount['profile_picture']
                    .toString()
                    .isEmpty
                ? const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/profile.jpeg'),
                  )
                : CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      widget.post.userAccount['profile_picture'].toString(),
                    ),
                    backgroundColor: Colors.red,
                  ),
            title: Text(
              widget.post.userAccount['username'].toString(),
            ),
            subtitle: Text(
              Jiffy.parse(widget.post.dateCreated).fromNow(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w200,
              ),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.post.postType == "VisualPost")
                  SizedBox(
                    height: 400,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: widget.post.pictures.length > 3
                          ? 4
                          : widget.post.pictures.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 3 && widget.post.pictures.length > 3) {
                          return GestureDetector(
                            onTap: () {
                              // Handle when the +3 others tile is tapped
                            },
                            child: Container(
                              color: Colors.grey,
                              child: Center(
                                child: Text(
                                  '+${widget.post.pictures.length - 3} others',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Image.network(
                            widget.post.pictures[index]['image'],
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: SizedBox(
              width: 300,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 1,
                          color: widget.post.liked == true
                              ? CustomColors().redColor
                              : CustomColors().textColor,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          widget.post.liked == true
                              ? Icon(
                                  Icons.recommend,
                                  color: CustomColors().redColor,
                                )
                              : const Icon(
                                  Icons.recommend,
                                ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(widget.post.likesCount.toString())
                        ],
                      ),
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
                    child: Row(
                      children: [
                        const Icon(Icons.chat),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(widget.post.commentCount.toString())
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
