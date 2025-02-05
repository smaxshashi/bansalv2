import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/shimmers/Light_categories_shimmer.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/hooks/fetch_occasion.dart';
import 'package:gehnamall/models/occasion/occasion_models.dart';
import 'package:gehnamall/views/home/occasion/occasion_product_screen.dart';
import 'package:gehnamall/views/home/occasion/occasion_widgets.dart';
import 'package:get/get.dart';

class OccasionList extends HookWidget {
  const OccasionList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchOccasion();
    List<OccasionModels>? occasionList = hookResult.data;
    final isLoading = hookResult.isloading;
    final error = hookResult.error;

    if (isLoading) {
      return const LightCatergoriesShimmer();
    }

    if (error != null) {
      return Center(
        child: Text(
          'Error: Sorry Plz Try with Good Internet',
          style: TextStyle(fontSize: 16.sp, color: Colors.red),
        ),
      );
    }

    if (occasionList == null || occasionList.isEmpty) {
      return Center(
        child: Text(
          'No categories available.',
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      );
    }

return Stack(
  children: [
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal scrollable list
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(occasionList.length, (i) {
                OccasionModels occasion = occasionList[i];
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width - 48.w) / 3,
                    child: OccasionWidgets(
                      image: occasion.imageUrl,
                      title: occasion.giftingName,
                      onTap: () {
                        Get.to(() => OccasionProductScreen(
                              occasion: occasion.giftingName,
                            ));
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    ),
  Positioned(
  bottom: 10.h, // Adjust the bottom position
  right: 10.w, // Adjust the right position
  child: Container(
     width: 35.w, // Set a fixed width for the container
    height: 35.h,
    decoration: BoxDecoration(
      color: kDark, // Set your desired background color here
      borderRadius: BorderRadius.circular(30), // Optional: Makes the background color rounded
    ),
    child: IconButton(
      icon: Icon(Icons.arrow_forward_rounded, size: 20.sp, color: Colors.white),
      onPressed: () {
        // Add your onPressed functionality
      },
    ),
  ),
),

  ],
);
}
}
