import 'package:turi/app/data/remote/model/home/category_response.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart';

import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';
class HomeRepository {

  Future<HomeResponse> getHomeData() async {
    var response = await ApiClient().get(
      ApiEndPoints.home,
      getHomeData,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return homeResponseFromJson(response.toString());
  }

  Future<CategoryResponse> getCategoriesData() async {
    var response = await ApiClient().get(
      ApiEndPoints.categories,
      getCategoriesData,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return categoryResponseFromJson(response.toString());
  }




}
