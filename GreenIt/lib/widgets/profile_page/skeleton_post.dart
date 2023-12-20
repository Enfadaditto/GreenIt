import 'package:flutter/material.dart';

Widget buildPlaceholderGallery(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Column(
      children: [
        const TabBar(
          labelColor:
              Color(0xFF269A66), // Set unselected tabs to be transparent
          indicatorColor: Color(0xFF269A66),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(text: '... Posts'),
            Tab(text: '... Liked'),
          ],
        ),
        SizedBox(
          height: 261 * 2, // Adjust the height as needed
          child: TabBarView(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 5.0),
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildPlaceholderPostContainer(context),
                          buildPlaceholderPostContainer(context)
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildPlaceholderPostContainer(context),
                          buildPlaceholderPostContainer(context)
                        ]),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildPlaceholderPostContainer(context),
                          buildPlaceholderPostContainer(context)
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildPlaceholderPostContainer(context),
                          buildPlaceholderPostContainer(context)
                        ]),
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

Widget buildPlaceholderPostContainer(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double width = screenWidth / 2 - 15;
  return Container(
    width: width, // Adjusted width for consistency
    height: 261,
    padding: const EdgeInsets.all(5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Placeholder for the photo
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade300, // Use a placeholder color
          ),
        ),
        // Padding (10px)
        const SizedBox(height: 10),
        // Placeholder for the description
        Container(
          width: width - 10,
          height: 20, // Adjusted width for consistency
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300, // Use a placeholder color
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ],
    ),
  );
}
