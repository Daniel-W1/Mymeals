import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:http/http.dart' as http;
import 'package:my_meals/features/meals/domain/meal.dart';

getRestuarantMeals(String url, someData) async {
  final response = await http.get(Uri.parse(url));

  // print(response.statusCode);
  // print('we are here');

  if (response.statusCode == 200) {
    final soup = BeautifulSoup(response.body);
    // print(soup);

    // find the first div with data-testid = scroll-container

    final mealWrapper =
        soup.find('div', attrs: {'data-testid': 'scroll-container'});

    // now find all div with dishWrapper__09f24__Bj2sT class
    final mealContainer = mealWrapper
        ?.findAll('div', attrs: {'class': 'dishWrapper__09f24__Bj2sT'});

    print(mealContainer?.length);

    List<Meal> meals = [];
    for (var meal in mealContainer ?? []) {
      // find the image continaer and get the image url
      final imageContainer =
          meal.find('div', attrs: {'class': 'dishPhoto__09f24__Gb3Mw'});
      final imageUrl = imageContainer?.find('img')?.attributes['src'];

      // find the name of the meal from p tag
      final nameContainer = meal.find('p', attrs: {'class': 'css-nyjpex'});
      final name = nameContainer?.text;

      meals.add(Meal(
        name: name ?? '',
        description: '',
        cuisineType: '',
        mealType: '',
        imageUrl: imageUrl ?? '',
        restaurantName: someData['name'],
        restaurantAddress: someData['address'],
      ));
    }

    return meals;
  } else {
    print('Failed to load the webpage: ${response.statusCode}');
  }
}

// void main() async {
//   final res = await getMeals(
//       'https://www.yelp.com/biz/the-emerald-hour-mountain-view-2?adjust_creative=8BUrBohSF7aSyBUyXRQePw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=8BUrBohSF7aSyBUyXRQePw');

//   for (var meal in res) {
//     print(meal.toJson());
//     print('------------------');
//   }
// }
