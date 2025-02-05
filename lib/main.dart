import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/CacheService.dart';
import 'package:gehnamall/SplashScreen.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:gehnamall/controllers/product_details_controller.dart';
import 'package:gehnamall/hooks/fetch_gifting_list.dart';
import 'package:gehnamall/hooks/fetch_occasion_list.dart';
import 'package:gehnamall/hooks/fetch_soulmate_list.dart';
import 'package:gehnamall/views/entrypoint.dart';
import 'package:get/get.dart';

Widget defaultHome = MainScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize cache and preload resources
  await CacheService.instance.initialize();

  Get.put(CartController());
  Get.put(OccasionSoulmateController());
  Get.put(OccasionGiftingController());
  Get.put(OccasionController());
  Get.put(ProductDetailsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GehnaMall',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            primarySwatch: Colors.grey,
          ),
          home: const SplashScreen(), // Show splash screen initially
        );
      },
    );
  }
}
