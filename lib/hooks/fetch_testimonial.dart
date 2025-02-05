import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gehnamall/hooks/fetch_wholesaler_id.dart';
import 'package:gehnamall/models/hook_models/hook_result.dart';
import 'package:gehnamall/models/testimonial_models.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchTestimonial() {
  final testimonialItems = useState<List<TestimonialModels>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = null;

    try {
      // Fetch wholesalerId dynamically
      final wholesalerId = await fetchWholesalerId();
      if (wholesalerId == null) {
        throw Exception('Failed to fetch wholesalerId');
      }

      final url = Uri.parse(
          'https://upload-service-254137058023.asia-south1.run.app/upload/$wholesalerId/testimonial');

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        testimonialItems.value = testimonialModelsFromJson(response.body);
      } else {
        throw Exception('Failed to load testimonials: ${response.statusCode}');
      }
    } on Exception catch (e) {
      error.value = e;
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
    data: testimonialItems.value,
    isloading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
