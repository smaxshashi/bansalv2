import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/custom_button.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:gehnamall/controllers/product_details_controller.dart';
import 'package:gehnamall/models/occasion/occasion_card_models.dart';
import 'package:gehnamall/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class GiftingProductDetailedScreen extends StatelessWidget {
  final OccasionCard product;
  final cartController = Get.put(CartController());
  final ProductDetailsController controller =
      Get.put(ProductDetailsController());

  GiftingProductDetailedScreen({Key? key, required this.product})
      : super(key: key);

  Future<String> getUserId() async {
    final userId = await AuthService.getUserId();
    return userId ?? 'Unknown';
  }

  // Launch a URL or perform a specific action
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url); // Ensure the URL is parsed as Uri
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Use launchUrl instead of launch
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error retrieving user ID.'));
        }

        final userId = snapshot.data ?? 'Unknown';

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Horizontal Image Slider
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        child: Container(
                          height: 300.h, // Use ScreenUtil for height
                          child: PageView.builder(
                            controller: controller.pageController,
                            onPageChanged: (index) =>
                                controller.currentImageIndex.value = index,
                            itemCount: product.imageUrls.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 300.h,
                                child: CachedNetworkImage(
                                  imageUrl: product.imageUrls[index],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, error, stackTrace) =>
                                      Icon(Icons.broken_image, size: 220.h),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.h,
                        child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(product.imageUrls.length, (index) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                              width: controller.currentImageIndex.value == index ? 12.w : 8.w,
                              height: controller.currentImageIndex.value == index ? 12.h : 8.h,
                              decoration: BoxDecoration(
                                color: controller.currentImageIndex.value == index
                                    ? Colors.white
                                    : Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        )),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Product Name
                  Center(
                    child: Text(
                      product.productName,
                      style: TextStyle(
                        fontSize: 28.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Product Details
                  Padding(
                    padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Karat: ${product.karat}',
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Weight: ${product.weight}gm',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'MakingCharge: ${product.wastage}%',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Description:${product.description}',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: 300.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _launchUrl('https://wa.me/+917982031621'),
                                icon: Image.asset(
                                  'assets/icons/whatsapp.png',
                                  height: 14.h,
                                ),
                                label: Text(
                                  'Click WhatsApp to ask!',
                                  style: TextStyle(color: Colors.green, fontSize: 8.sp),
                                ),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(160.w, 15.h),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.green, width: 2.w),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              ElevatedButton.icon(
                                onPressed: () => _launchUrl('tel:+917982031621'),
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                  size: 14.h,
                                ),
                                label: Text(
                                  'Click to Call!',
                                  style: TextStyle(color: Colors.green, fontSize: 8.sp),
                                ),
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Colors.green, width: 2.w),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.verified, color: kPrimary),
                            SizedBox(width: 8.w),
                            Text(
                              'Bansal & Sons Jewellers',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Add to Wishlist Button
                  CustomButton(
                    label: 'Add to Wishlist',
                    onPressed: () {
                      cartController.addToCart(userId, product.productId.toString());
                    },
                    width: 550.w, 
                    height: 50.h,
                    color: kDark,
                    fontSize: 20.sp,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
