import 'dart:convert';
import 'package:gehnamall/models/occasion/occasion_card_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OccasionGiftingController extends GetxController {
  var isLoading = true.obs;
  var giftingCardModels = Rx<OccasionCardModels?>(null);
  var error = ''.obs;

  // Fetch the product data from the new POST API
  Future<void> fetchGiftingProducts(String gifting) async {
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
        "gifting": gifting,
      });

      // Send POST request
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        giftingCardModels.value = occasionCardModelsFromJson(response.body);
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
