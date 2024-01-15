import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sida_mangan/data/api/api_service.dart';
import 'package:sida_mangan/data/model/restaurant_model.dart';
import 'package:sida_mangan/provider/restaurants_provider.dart';

import 'restaurant_provider_test.mocks.dart';

class ApiServiceTest extends Mock implements ApiService {}

const apiListResponse = {
  "error": false,
  "message": "success",
  "count": 2,
  "restaurants": [
    {
      "id": "dwg2wt3is19kfw1e867",
      "name": "Drinky Squash",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "18",
      "city": "Surabaya",
      "rating": 3.9
    },
    {
      "id": "6u9lf7okjh9kfw1e867",
      "name": "Ampiran Kota",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "35",
      "city": "Balikpapan",
      "rating": 4.1
    },
  ]
};

List<Restaurant> testRestaurants = [
  Restaurant(
    id: "dwg2wt3is19kfw1e867",
    name: "Drinky Squash",
    description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    pictureId: "18",
    city: "Surabaya",
    rating: 3.9,
  ),
  Restaurant(
    id: "6u9lf7okjh9kfw1e867",
    name: "Ampiran Kota",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "35",
    city: "Balikpapan",
    rating: 4.1,
  ),
];


@GenerateMocks([ApiServiceTest])
Future<void> main() async {
  group("Restaurant Provider Test", () {
    late RestaurantsProvider restaurantProvider;
    late ApiService apiService;

    setUp(() {
      apiService = MockApiServiceTest();
      restaurantProvider = RestaurantsProvider(apiService: apiService);
    });

    test("fetchAllRestaurant should return list of restaurants", () async {
      when(apiService.listRestaurant())
          .thenAnswer((_) async => RestaurantsModel.fromJson(apiListResponse));

      await restaurantProvider.fetchAllRestaurant();

      var result = restaurantProvider.result.restaurants;
      var expected = testRestaurants;

      expect(result.length == expected.length, true);
      expect(result[0].id == expected[0].id, true);
      expect(result[0].name == expected[0].name, true);
      expect(result[0].description == expected[0].description, true);
      expect(result[0].pictureId == expected[0].pictureId, true);
      expect(result[0].city == expected[0].city, true);
      expect(result[0].rating == expected[0].rating, true);
    });
  });
}
