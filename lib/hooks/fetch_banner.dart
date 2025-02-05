import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gehnamall/models/hook_models/hook_result.dart';
import 'package:http/http.dart' as http;

import '../hooks/fetch_wholesaler_id.dart'; // Import the fetchWholesalerId function
import '../models/banner_models.dart';

FetchHook useFetchBanner() {
  // State variables to hold the banners, loading state, and error.
  final banners = useState<List<BannerModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  // Async function to fetch data from the API.
  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = null; // Reset the error before making the API call.

    try {
      // Fetch the wholesalerId dynamically.
      final wholesalerId = await fetchWholesalerId();
      if (wholesalerId == null) {
        throw Exception('wholesalerId could not be fetched.');
      }

      // Construct the API URL with the wholesalerId.
      final url = Uri.parse(
          'https://upload-service-254137058023.asia-south1.run.app/upload/$wholesalerId/getbanners');

      // API call to fetch banners.
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // Parse the response and update the state.
        banners.value = bannerModelFromJson(response.body);
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } on Exception catch (e) {
      error.value = e; // Store the error if an exception is thrown.
    } finally {
      isLoading.value = false;
    }
  }

  // The useEffect hook runs when the widget is first created or when dependencies change.
  useEffect(() {
    fetchData();
    return null;
  }, []); // Empty list ensures this effect runs only once.

  // Return the state encapsulated in the FetchHook class.
  return FetchHook(
    data: banners.value,
    isloading: isLoading.value,
    error: error.value,
    refetch: fetchData,
  );
}
