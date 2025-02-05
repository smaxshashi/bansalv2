import 'package:gehnamall/models/hook_models/hook_result.dart';
import 'package:gehnamall/models/light_category_models.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../models/api_error.dart';
import 'package:http/http.dart' as http;
import 'fetch_wholesaler_id.dart'; // Import the wholesalerId fetcher

FetchHook UseFetchLightCategories() {
  final LightCategoriesItems = useState<List<LightCategoryModels>?>(null);
  final isLoading = useState<bool>(false);
  final error =
      useState<String?>(null); // Change to String? to handle any error message
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      // Fetch the wholesalerId dynamically
      final wholesalerId = await fetchWholesalerId();
      print("Wholesaler ID: $wholesalerId"); // Log the wholesaler ID
      if (wholesalerId == null) {
        throw Exception("Failed to fetch wholesalerId");
      }

      // Construct the API URL with the wholesalerId
      Uri url = Uri.parse(
          'https://upload-service-254137058023.asia-south1.run.app/upload/$wholesalerId/getCategory?categoryType=light');
      print("API URL: $url"); // Log the constructed API URL

      // Make the GET request
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print("Response Status: ${response.statusCode}"); // Log the status code
      print("Response Body: ${response.body}"); // Log the response body

      if (response.statusCode == 200) {
        try {
          // Parse the successful response
          LightCategoriesItems.value =
              lightCategoryModelsFromJson(response.body);
        } catch (e) {
          print("Error parsing response: $e"); // Log parsing errors
          error.value = "Error parsing response: $e";
        }
      } else {
        // Handle API error
        print("API Error: ${response.body}"); // Log the API error response
        apiError.value = apiErrorFromJson(response.body);
        error.value = "API Error: ${response.statusCode}";
      }
    } catch (e) {
      // Handle any type of error
      print("Error: $e"); // Log the error for better debugging
      error.value = e.toString(); // Assign the error message
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    print("Fetching data..."); // Log the start of data fetching
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: LightCategoriesItems.value,
    isloading: isLoading.value,
    error: error.value != null
        ? Exception(error.value)
        : null, // Convert error to Exception if needed
    refetch: refetch,
  );
}
