import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gehnamall/hooks/fetch_wholesaler_id.dart';
import 'package:gehnamall/models/api_error.dart';
import 'package:gehnamall/models/category_models.dart';
import 'package:gehnamall/models/hook_models/hook_result.dart';
import 'package:http/http.dart' as http;

FetchHook UseFetchCategories() {
  final CategoriesItems = useState<List<CategoryModels>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  /// Fetch categories using the wholesalerId
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      // Fetch the wholesalerId
      final wholesalerId = await fetchWholesalerId();
      if (wholesalerId == null) {
        throw Exception('Invalid wholesalerId');
      }

      // Use the fetched wholesalerId to construct the URL
      Uri url = Uri.parse(
          'https://upload-service-254137058023.asia-south1.run.app/upload/$wholesalerId/getCategory');
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      // Handle the response
      if (response.statusCode == 200) {
        CategoriesItems.value = categoryModelsFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      error.value = e as Exception;
    } finally {
      isLoading.value = false;
    }
  }

  // Automatically fetch data on hook initialization
  useEffect(() {
    fetchData();
    return null;
  }, []);

  // Refetch function to allow manual reloading
  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  // Return hook result
  return FetchHook(
    data: CategoriesItems.value,
    isloading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
