class ApiEndpoints {
  ApiEndpoints._();
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:5000/api/";
  static const String baseUrl = "http://192.168.68.55:5000/api/";
  // For iPhone
  // static const String baseUrl = "http://localhost:5000/api/v1/";

  //========================Auth========================//
  static const String login = "user/login";
  static const String register = "user/register";
  static const String singleUser = "user";
  static const String uploadImage = "user/uploadImage";
  static const String profileImage = 'user/getProfileImage/';

  //========================Recipe========================//
  static const String createRecipe = "recipe";
  static const String getAllRecipe = "recipe";

  //pass image name as params
  static const String recipeImage = 'recipe/getRecipeImage/';
  static const String uploadRecipeImage = "recipe/uploadImage";

  //pass id as params
  static const String likeRecipe = "rating/recipe/";
  static const String getUserlikedRecipe = "rating/user/";
  static const String getUserRecipes = "recipe/user/";
}
