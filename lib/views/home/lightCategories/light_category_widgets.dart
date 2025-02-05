// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/models/light_category_models.dart';
import 'package:gehnamall/views/home/lightCategories/light_product_screen.dart';
import 'package:get/get.dart';

class LightCategoryWidget extends StatelessWidget {
  LightCategoryWidget({
    super.key,
    required this.lightCategories,
  });

  final LightCategoryModels lightCategories;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the product screen on tap
        Get.to(() => LightProductScreen(
              categoryId: lightCategories.categoryId.toString(),
              wholesalerId: lightCategories.wholesalerId,
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        padding: EdgeInsets.symmetric(vertical: 6.h),
        width: 65.w, // Increased width for better proportions
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
         
        ),
        child: SingleChildScrollView(  // Wrap the column with SingleChildScrollView
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60.h, // Increased image size
                width: 60.h,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: lightCategories.imageUrl.toString(),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, size: 25.r),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Flexible(
                child: Text(
                  lightCategories.categoryName,
                  style: TextStyle(
                    fontSize: 12.sp, // Increased font size
                    color: kDark,
                    fontWeight: FontWeight.bold, // Enhanced visibility
                  ),
                  
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
