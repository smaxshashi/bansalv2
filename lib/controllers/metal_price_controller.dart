// controllers/metal_price_controller.dart
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../hooks/fetch_wholesaler_id.dart'; // Import the wholesaler ID fetcher
import '../models/metal_price.dart';

class MetalPriceController extends GetxController {
  var prices = <MetalPrice>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPrices();
    super.onInit();
  }

  void fetchPrices() async {
    try {
      isLoading(true);

      // Fetch the wholesaler ID dynamically
      int? wholesalerId = await fetchWholesalerId();
      if (wholesalerId == null) {
        throw Exception('Wholesaler ID is null');
      }

      // Construct the API URL with the fetched wholesaler ID
      Uri apiUrl = Uri.parse(
          'https://upload-service-254137058023.asia-south1.run.app/upload/$wholesalerId/getMetalPrice');

      // Send the GET request
      var response = await http.get(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List;
        prices.value =
            jsonData.map((data) => MetalPrice.fromJson(data)).toList();
      } else {
        throw Exception(
            'Failed to fetch metal prices. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching prices: $e');
    } finally {
      isLoading(false);
    }
  }
}
