import 'package:get/get.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/data/remote/model/wishlist/wishlist_response.dart';
import 'package:turi/app/data/remote/repository/wishlist/wishlist_repository.dart';

class WishlistController extends GetxController {
  final wishlistItems = <WishlistItems>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getWishlist();
  }

  Future<void> getWishlist() async {
    isLoading.value = true;
    var response = await WishlistRepository().getWishlist();

    if (response.data!.data!.isNotEmpty) {
      wishlistItems.clear();
      wishlistItems.addAll(response.data!.data!);
    } else {
      printLog('Wishlist is empty');
    }
    isLoading.value = false;
  }

  void wishlistAction(String id)async {
    var response = await WishlistRepository().addToWishlist(id);
    if (response.status==200) {
      wishlistItems.clear();
      getWishlist();
    } else {
      AppWidgets().getSnackBar(message: response.message);
    }
    isLoading.value = false;

  }
}
