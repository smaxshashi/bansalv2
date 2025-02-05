import 'dart:convert';
import 'package:gehnamall/models/lightcategorycardModels.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LightController extends GetxController {
  var isLoading = true.obs;
  var lightCardModels = Rx<LightCardModels?>(null);
  var error = ''.obs;

  // Fetch the product data from the new API
  Future<void> fetchLightProducts(String categoryId, int wholesalerId) async {
    try {
      isLoading.value = true;
      error.value = '';

      // Define the API endpoint
      final Uri url = Uri.parse(
          'https://product-service-254137058023.asia-south1.run.app/product/getProducts');

      // Create the request body
      final Map<String, dynamic> body = {
        "categoryId": categoryId,
        "wholesalerId": wholesalerId,
      };

      // Make the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Parse and assign the response
        lightCardModels.value = lightCardModelsFromJson(response.body);
      } else {
        error.value =
            'Failed to load products: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
