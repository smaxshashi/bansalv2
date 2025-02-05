import 'dart:convert';
import 'package:gehnamall/models/occasion/occasion_card_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OccasionSoulmateController extends GetxController {
  var isLoading = true.obs;
  var soulmateCardModels = Rx<OccasionCardModels?>(null);
  var error = ''.obs;

  // Fetch the product data from the API
  Future<void> fetchSoulmateProducts(String soulmate) async {
    try {
      final uri = Uri.parse(
        'https://product-service-254137058023.asia-south1.run.app/product/getProducts',
      );

      // API headers
      final headers = {
        'Content-Type': 'application/json',
      };

      // API request body
      final body = jsonEncode({
        "soulmate": soulmate,
      });

      // Send POST request
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        soulmateCardModels.value = occasionCardModelsFromJson(response.body);
        isLoading.value = false;
      } else {
        error.value = 'Failed to load products: ${response.reasonPhrase}';
        isLoading.value = false;
      }
    } catch (e) {
      error.value = 'Error: $e';
      isLoading.value = false;
    }
  }
}
