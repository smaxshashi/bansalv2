//lib\hooks\fetch_wholesaler_id.dart

import 'package:http/http.dart' as http;

/// Fetches the wholesalerId dynamically from the provided API.
Future<int?> fetchWholesalerId() async {
  try {
    Uri wholesalerIdUrl = Uri.parse(
        'https://admin-service-254137058023.asia-south1.run.app/admin/auth/wholesalerId/BANSAL');
    final response = await http.get(
      wholesalerIdUrl,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return int.tryParse(response.body);
    } else {
      throw Exception('Failed to fetch wholesalerId');
    }
  } catch (e) {
    throw Exception('Error fetching wholesalerId: $e');
  }
}
