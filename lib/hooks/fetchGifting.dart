import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gehnamall/models/gifting/gifting_models.dart';
import 'package:gehnamall/models/hook_models/hook_result.dart';
import '../models/api_error.dart';
import 'package:http/http.dart' as http;
import 'package:gehnamall/hooks/fetch_wholesaler_id.dart'; // Import wholesaler ID fetcher

FetchHook UseFetchGifting() {
  final GiftingItems = useState<List<GiftingModels>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      // Step 1: Fetch wholesalerId
      final wholesalerId = await fetchWholesalerId();
      if (wholesalerId == null) {
        throw Exception('Wholesaler ID is null');
      }

      // Step 2: Construct API URL
      Uri url = Uri.parse(
          'https://upload-service-254137058023.asia-south1.run.app/upload/$wholesalerId/gifting');

      // Step 3: Fetch data from API
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        GiftingItems.value = giftingModelsFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      error.value = e as Exception;
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: GiftingItems.value,
    isloading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
