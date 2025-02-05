import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/models/sub_categories_models.dart';
import 'package:gehnamall/views/home/category_for_menu/product_card_menu/product_list.dart';
import 'package:http/http.dart' as http;
import 'package:gehnamall/hooks/fetch_wholesaler_id.dart'; // Import wholesaler ID fetcher

class SubcategoryList extends StatefulWidget {
  final int categoryId;
  final String? selectedGender; // Updated to use gender as a string
  final void Function()? onTap;

  const SubcategoryList({
    Key? key,
    required this.categoryId,
    this.selectedGender,
    this.onTap,
  }) : super(key: key);

  @override
  _SubcategoryListState createState() => _SubcategoryListState();
}

class _SubcategoryListState extends State<SubcategoryList> {
  List<SubCategoryModels>? subcategories;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchSubcategories();
  }

  Future<void> fetchSubcategories() async {
    setState(() => isLoading = true);

    try {
      // Fetch the wholesaler ID dynamically
      final wholesalerId = await fetchWholesalerId();
      if (wholesalerId == null) throw Exception("Wholesaler ID is null");

      // Build API URL
      String url =
          'https://upload-service-254137058023.asia-south1.run.app/upload/$wholesalerId/getSubCategories/${widget.categoryId}';
      if (widget.selectedGender != null) {
        url += '?gender=${widget.selectedGender}';
      }

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final fetchedSubcategories = subCategoryModelsFromJson(response.body);
        subcategories = fetchedSubcategories;
      } else {
        error = 'Failed to fetch subcategories: ${response.statusCode}';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Text(
          error!,
          style: const TextStyle(fontSize: 18.0, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (subcategories == null || subcategories!.isEmpty) {
      return const Center(
        child: Text(
          'No Subcategories Found',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDark,
        automaticallyImplyLeading: false,
        title: Text(
          'Subcategory',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:ListView.separated(
  itemCount: subcategories!.length,
  separatorBuilder: (context, index) => Divider(),
  itemBuilder: (context, index) {
    final subcategory = subcategories![index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductList(
              categoryCode: widget.categoryId,
              subCategoryCode: subcategory.subcategoryId,
              subCategoryName: subcategory.subCategoryName,
              wholesalerId: subcategory.wholesalerId,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              subcategory.imageUrl?.isNotEmpty ?? false
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        subcategory.imageUrl!,
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.image, size: 80.0),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  subcategory.subCategoryName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
)
),
    );
  }
}
