import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/app_style.dart';

class SoulmateWidgets extends StatelessWidget {
  const SoulmateWidgets({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  final String image;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.w), // Use screen width scaling for padding
        child: Container(
          width: 150.w, // Scaled width
          height: 260.h, // Scaled height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200.h, // Scaled height for the image container
                width: double.infinity,
              
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w, // Scales horizontal padding
                  vertical: 3.h, // Scales vertical padding
                ),
             child: Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.yellow,
      width: 3.0, // Use a fixed value or make sure 3.w is valid if you're using a custom scale.
    ),
    borderRadius: BorderRadius.circular(8), // Adds rounded corners
    color: Colors.white, // Optional: add a background color to the container
  ),
  padding: EdgeInsets.all(8.0), // Adds padding inside the container
  child: FittedBox(
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: appStyle(15, Colors.black, FontWeight.normal),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  ),
),
 ),
            ],
          ),
        ),
      ),
    );
  }
}
