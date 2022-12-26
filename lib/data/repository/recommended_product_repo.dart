import 'package:get/get.dart';

import '../../resources/app_constants.dart';
import '../api/api_client.dart';

class RecommendedProductRepo extends GetxService {
  final APIClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMEND_PRODUCT_URL);
  }
}
