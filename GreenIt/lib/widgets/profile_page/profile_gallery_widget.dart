import 'package:flutter/material.dart';
import 'package:my_app/Models/Comment.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/pages/post_page.dart';

SingleChildScrollView buildProfileGallery(
    BuildContext context, List<Post> posts) {
  List<Widget> postWidgets = [];
  Widget lastWidget;

  for (int index = 0; index < posts.length; index += 2) {
    Post post1 = posts[index];
    String imageUrl1 = post1.firstStep?.image ??
        'https://consolidatedlabel.com/app/uploads/2007/10/low-res-72dpi.jpg'; // Adjust this based on your actual structure
    String description1 = post1.description;

    Widget postWidget1 =
        buildPostWidget(context, index, imageUrl1, description1);

    // Check if there is a second post in the row
    if (index + 1 < posts.length) {
      Post post2 = posts[index + 1];
      String imageUrl2 = post2.firstStep?.image ??
          'https://consolidatedlabel.com/app/uploads/2007/10/low-res-72dpi.jpg'; // Adjust this based on your actual structure
      String description2 = post2.description;

      Widget postWidget2 =
          buildPostWidget(context, index + 1, imageUrl2, description2);

      // Add a row with two posts
      postWidgets.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [postWidget1, postWidget2],
          ),
        ),
      );
    } else {
      // Add a single post if there is no second post in the row
      postWidgets.add(postWidget1);
      lastWidget = postWidget1;
    }
  }

  return SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Column(
      children: postWidgets,
    ),
  );
}

Widget buildPostWidget(
    BuildContext context, int index, String imageUrl, String description) {
  double screenWidth = MediaQuery.of(context).size.width;
  double postWidth = screenWidth / 2 - 15;

  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PostPage(
            id: "",
            postId: -1, //Replace with the post ID
            author: 'Me', // Replace with the actual author
            title:
                'TITLE', // Replace with the actual title from the Post object
            comments: [],
            currentIndex: index,
          ),
        ),
      );
    },
    child: Container(
      width: postWidth,
      height: 265,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container for the photo
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Padding (10px)
          const SizedBox(height: 5),
          // Container for the description
          Container(
            width: postWidth - 10, // Adjusted width for consistency
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.white, // Adjust the color as needed
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              description,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
