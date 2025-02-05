
import 'dart:io';
import 'package:gehnamall/hooks/fetch_wholesaler_id.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Helper to append wholesalerId
  static Future<Uri> appendWholesalerId(Uri baseUri) async {
    final wholesalerId = await fetchWholesalerId();
    if (wholesalerId != null) {
      final newQuery = {
        ...baseUri.queryParameters,
        'wholesalerId': '$wholesalerId'
      };
      return baseUri.replace(queryParameters: newQuery);
    }
    return baseUri;
  }

  // Sign-Up Function
  static Future<Map<String, dynamic>> signUp(
      String phoneNumber, String name) async {
    final baseUrl = Uri.parse(
        'https://user-service-254137058023.asia-south1.run.app/user/register?phoneNumber=$phoneNumber&name=$name');
    final url = await appendWholesalerId(baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber, 'name': name}),
      );
      print('Signup response: ${response.body}');
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'data': data};
      }
    } catch (e) {
      print('Signup error: $e');
      return {
        'success': false,
        'data': {'message': 'Network error occurred'}
      };
    }
  }

  // Login Function
// Login Function
static Future<Map<String, dynamic>> login(String phoneNumber) async {
  final baseUrl = Uri.parse(
      'https://user-service-254137058023.asia-south1.run.app/user/login?phoneNumber=$phoneNumber');
  final url = await appendWholesalerId(baseUrl);

  try {
    final response = await http.get(url);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      // Check if status is -1
      if (data['status'] == -1) {
        return {
          'success': false,
          'data': {'message': 'User not Found. Please register First.'}
        };
      }
      return {'success': true, 'data': data};
    } else if (response.statusCode == 404) {
      return {
        'success': false,
        'data': {'message': 'User not registered'}
      };
    } else {
      return {'success': false, 'data': data};
    }
  } catch (e) {
    return {
      'success': false,
      'data': {'message': 'Network error occurred'}
    };
  }
}

  // OTP Verification Function
static Future<Map<String, dynamic>> verifyOtp(String phoneNumber, String otp) async {
  if (otp.length != 3) {
    return {
      'success': false,
      'data': {'message': 'OTP must be 3 digits long'}
    };
  }

  final baseUrl = Uri.parse(
      'https://user-service-254137058023.asia-south1.run.app/user/verify?phoneNumber=$phoneNumber&otp=$otp');
  final url = await appendWholesalerId(baseUrl);

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phoneNumber': phoneNumber, 'otp': otp}),
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      if (data['userId'] != null) {
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userId', data['userId'].toString());
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'data': {'message': 'Invalid OTP or OTP has Expired'}
        };
      }
    } else if (response.statusCode == 401) {
      return {
        'success': false,
        'data': {'message': 'OTP does not match. Please try again.'}
      };
    } else {
      return {'success': false, 'data': data};
    }
  } catch (e) {
    return {
      'success': false,
      'data': {'message': 'Network error occurred: $e'}
    };
  }
}

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // Defaults to false if not set
  }

  // Logout function
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("Logout successful. All relevant data cleared.");
  }

  // Fetch User ID from SharedPreferences
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId'); // Returns null if userId is not found
  }

  // Update User Details
  static Future<bool> updateUserDetails(
      String userId, Map<String, String> updatedDetails) async {
    final baseUrl = Uri.parse(
        'https://user-service-254137058023.asia-south1.run.app/user/update/$userId');
    final url = await appendWholesalerId(baseUrl);

    try {
      print("Request URL: $url");
      print("Request Data: $updatedDetails");

      final request = http.MultipartRequest('POST', url);
      updatedDetails.forEach((key, value) {
        request.fields[key] = value;
      });

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody);
        final status = jsonResponse['status'];
        final message = jsonResponse['message'];

        if (status == 0) {
          print('Update successful: $message');
          return true;
        } else {
          print('Update failed: $message');
          return false;
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error occurred during update: $e');
      return false;
    }
  }

  // Fetch User Details
  static Future<Map<String, dynamic>> getUserDetails(String userId) async {
    final baseUrl = Uri.parse(
        'https://user-service-254137058023.asia-south1.run.app/user/getUserDetail/$userId');
    final url = await appendWholesalerId(baseUrl);

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'data': data};
      }
    } catch (e) {
      return {
        'success': false,
        'data': {'message': 'Network error occurred'}
      };
    }
  }

  // Upload Image
  static Future<bool> uploadImageToServer(String userId, File image) async {
    final baseUrl = Uri.parse(
        'https://user-service-254137058023.asia-south1.run.app/user/update/$userId');
    final url = await appendWholesalerId(baseUrl);

    try {
      final request = http.MultipartRequest('POST', url);
      request.fields['userId'] = userId;
      request.files
          .add(await http.MultipartFile.fromPath('profileImage', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return false;
    }
  }
  // Delete Account Function
  static Future<Map<String, dynamic>> deleteAccount(String phoneNumber) async {
    final baseUrl = Uri.parse(
        'https://user-service-254137058023.asia-south1.run.app/user/accountDeletion');
    final url = await appendWholesalerId(baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'phoneNumber': phoneNumber,
          'wholesalerId': await fetchWholesalerId().toString(),
        },
      );
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'data': data};
      }
    } catch (e) {
      print('Delete Account error: $e');
      return {
        'success': false,
        'data': {'message': 'Network error occurred'}
      };
    }
  }

}
