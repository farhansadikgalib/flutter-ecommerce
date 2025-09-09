import 'package:flutter/material.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart';
import '../../../core/widget/product_card.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  // Replace this with your actual ecomCategories data source

  late final List<Category> categories;
  late final ValueNotifier<int> selectedIndex;

  @override
  void initState() {
    super.initState();
    // Extract unique categories from products
    // categories = products
    //     .map((p) => p.category)
    //     .whereType<Category>()
    //     .toSet()
    //     .toList();
    // selectedIndex = ValueNotifier<int>(0);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = categories.isNotEmpty ? categories[selectedIndex.value] : null;
    // final filteredProducts = selectedCategory == null
    //     ? products
    //     : products.where((p) => p.category?.id == selectedCategory.id).toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFe0eafc), Color(0xFFcfdef3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category selector
              Container(
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ValueListenableBuilder<int>(
                  valueListenable: selectedIndex,
                  builder: (context, selected, _) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selected == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.green[100] : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: isSelected ? Border.all(color: Colors.green, width: 2) : null,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () => selectedIndex.value = index,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 10,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.category,
                                      size: 26,
                                      color: isSelected ? Colors.green : Colors.grey[600],
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        category.name ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? Colors.green[900] : Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 28),
              // Expanded(
              //   child: GridView.builder(
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       childAspectRatio: 0.7,
              //       crossAxisSpacing: 16,
              //       mainAxisSpacing: 16,
              //     ),
              //     itemCount: filteredProducts.length,
              //     itemBuilder: (context, index) {
              //       return ProductCard(product: filteredProducts[index], index: index);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
