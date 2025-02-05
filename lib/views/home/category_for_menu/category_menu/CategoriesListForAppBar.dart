import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/hooks/fetchCategory.dart';
import 'package:gehnamall/models/category_models.dart';
import 'package:gehnamall/views/home/category_for_menu/4007_menu/gold_brick.dart';
import 'package:gehnamall/views/home/category_for_menu/category_menu/CategoriesWidgetsForAppBar.dart';
import 'package:gehnamall/views/home/category_for_menu/gender_selction_menu/Gender_selection.dart';
import 'package:gehnamall/views/home/category_for_menu/subCategory_menu/subcategory_list.dart';
import 'package:get/get.dart';

class CategoriesListForAppBar extends HookWidget {
  const CategoriesListForAppBar({super.key});

  static List<CategoryModels>? _cachedCategoriesList; // Memory cache for categories

  @override
  Widget build(BuildContext context) {
    final hookResult = UseFetchCategories();
    List<CategoryModels>? categoriesList = _cachedCategoriesList ?? hookResult.data;
    final isLoading = hookResult.isloading && _cachedCategoriesList == null; // Show loading only on first fetch
    final error = hookResult.error;

    // Ensure proper initialization of ScreenUtil
    ScreenUtil.init(context);

    // Cache the categoriesList once fetched
    if (categoriesList != null && categoriesList.isNotEmpty && _cachedCategoriesList == null) {
      _cachedCategoriesList = categoriesList;
    }

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if (error != null) {
      return Center(
        child: Text(
          'Error: Sorry, please try with good internet',
          style: TextStyle(fontSize: 16.sp, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (categoriesList == null || categoriesList.isEmpty) {
      return Center(
        child: Text(
          'No categories available.',
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: categoriesList.length,
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemBuilder: (context, i) {
          CategoryModels category = categoriesList[i];
          return CategoriesWidgetsForAppBar(
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
                          selectedGender: selectedGender, // Pass gender as a string
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
          );
        },
      ),
    );
  }
}
