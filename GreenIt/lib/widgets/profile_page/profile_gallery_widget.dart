import 'package:flutter/material.dart';
import 'package:my_app/Models/Post.dart';
import 'package:my_app/Persistance/RepoPost.dart';
import 'package:my_app/pages/post_page.dart';

GridView buildProfileGallery(BuildContext context, List<Post> posts) =>
    GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        Post post = posts[index];
        String imageUrl = post.firstStep?.image ??
            'https://consolidatedlabel.com/app/uploads/2007/10/low-res-72dpi.jpg'; // Adjust this based on your actual structure

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                  PostPage(
                    author: 'Me', // Replace with the actual author
                    id: "15",
                    title:
                      'TITLE', // Replace with the actual title from the Post object
                    currentIndex: index,
                ),
              ),
            );
          },
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
