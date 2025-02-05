import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/shimmers/Light_categories_shimmer.dart';
import 'package:gehnamall/hooks/fetchCategory.dart';
import 'package:gehnamall/models/category_models.dart';
import 'package:gehnamall/views/home/4007/gold_brick.dart';
import 'package:gehnamall/views/home/category/categories_widgets.dart';
import 'package:gehnamall/views/home/category/gender_selction/Gender_selection.dart';
import 'package:gehnamall/views/home/category/subCategory/subcategory_list.dart';
import 'package:get/get.dart';

class CategoriesList extends HookWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = UseFetchCategories();
    List<CategoryModels>? categoriesList = hookResult.data;
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

    if (categoriesList == null || categoriesList.isEmpty) {
      return Center(
        child: Text(
          'No categories available.',
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 12.w, top: 10.h, right: 12.w),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 1.w, // Space between items horizontally
          runSpacing: 1.h, // Space between rows
          children: List.generate(categoriesList.length, (i) {
            CategoryModels category = categoriesList[i];
            return SizedBox(
              width: (ScreenUtil().screenWidth - 48.w) / 3, // 3 items per row
              child: CategoriesWidgets(
                image: category.imageUrl,
                title: category.categoryName,
                onTap: () {
                  if ([30, 31, 32].contains(category.categoryId)) {
                    Get.to(
                      () => ProductsList(
                        wholesalerId: category.wholesalerId,
                        categoryId: category.categoryId.toString(),
                      ),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 900),
                    );
                  } else if (category.categoryId == 24 ||
                      category.categoryId == 25) {
                    Get.to(
                      () => GenderSelection(
                        onGenderSelected: (String selectedGender) {
                          Get.to(
                            () => SubcategoryList(
                              categoryId: category.categoryId,
                              selectedGender:
                                  selectedGender, // Pass gender as a string
                            ),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 900),
                          );
                        },
                      ),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 900),
                    );
                  } else {
                    Get.to(
                      () => SubcategoryList(categoryId: category.categoryId),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 900),
                    );
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
