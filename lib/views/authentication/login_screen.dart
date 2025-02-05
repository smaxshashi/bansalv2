import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/views/authentication/signup_screen.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../main.dart';
import '../../services/auth_service.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  bool isLoading = false;

  void handleLogin() async {
    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter phone number',
          backgroundColor: Colors.white, colorText: Colors.black);
      return;
    }

    setState(() => isLoading = true);

    final result = await AuthService.login(phoneController.text);

    setState(() => isLoading = false);

    if (result['success']) {
      Get.to(() => OtpScreen(phoneNumber: phoneController.text));
    } else {
      String errorMessage = result['data']['message'] ?? 'Login failed. Please try again.';
      
      if (errorMessage == 'User not Found. Please register First.') {
        Get.snackbar('Oops', errorMessage,
            backgroundColor: Colors.white, colorText: Colors.black);
        return;
      }

      if (errorMessage == 'User not registered') {
        Get.snackbar('Oops', errorMessage,
            backgroundColor: Colors.white, colorText: Colors.black);
        Get.to(() => SignupScreen(phoneNumber: phoneController.text));
      } else {
        Get.snackbar('Error', errorMessage,
            backgroundColor: Colors.white, colorText: Colors.black);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/loginbackground.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/applogo.png',
                    height: 250.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0.w),
                    child: Card(
                      color: kWhite,
                      elevation: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 40.sp,
                                color: kDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Shin Bright with exclusive Jewellers',
                            style: TextStyle(fontSize: 15.sp, color: Colors.black),
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                prefixText: '+91 ',
                                border: OutlineInputBorder(),
                                labelText: 'Enter Phone Number',
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),
                          InkWell(
                            onTap: isLoading ? null : handleLogin,
                            child: Container(
                              height: 40.h,
                              width: 310.w,
                              decoration: const BoxDecoration(color: kDark),
                              child: Center(
                                child: isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text(
                                        'LOG IN',
                                        style: TextStyle(fontSize: 18.sp, color: kWhite),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  title: const Text('Login Required',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 18,
                                      )),
                                  content: const Text('Login to unlock more features.',
                                      style: TextStyle(color: Colors.black54, fontSize: 16)),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Get.to(() => defaultHome);
                                      },
                                      child: const Text('Cancel',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Login',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              height: 40.h,
                              width: 310.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: kDark, width: 3.w),
                              ),
                              child: Center(
                                child: Text('SKIP',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: kPrimary,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => const SignupScreen());
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: "Didn't have an account? ",
                                  style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                                  children: [
                                    TextSpan(
                                      text: 'Click here',
                                      style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}