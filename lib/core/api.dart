

sealed class Api{
  static const String baseUrl = "fakestoreapi.com";
  static const String apiProduct = "/products";
  static const String apiAddCart = "/carts";
  static const String apiUser = "/users";
  static const String apiCategory = "/products/categories";
  static const String apiGetSingleCategory = "products/category";
  static const Map<String, String> headersMedia = {
    'Content-Type': 'application/json'
  };
}