import 'package:flutter_test/flutter_test.dart';
import 'package:sida_mangan/data/model/restaurant_model.dart';

void main() {
  test('Testing to verify Restaurant json parsing', () {
    var result = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "w9pga3s2tubkfw1e867",
          "name": "Bring Your Phone Cafe",
          "description":
              "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
          "pictureId": "03",
          "city": "Surabaya",
          "rating": 4.2
        },
        {
          "id": "uewq1zg2zlskfw1e867",
          "name": "Kafein",
          "description":
              "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
          "pictureId": "15",
          "city": "Aceh",
          "rating": 4.6
        },
      ]
    };

    final restaurant = RestaurantsModel.fromJson(result);

    expect(restaurant.restaurants.length, 2);
    expect(restaurant.restaurants[0].id, "w9pga3s2tubkfw1e867");
    expect(restaurant.restaurants[0].name, "Bring Your Phone Cafe");
    expect(restaurant.restaurants[0].description,
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,");
    expect(restaurant.restaurants[0].pictureId, "03");
    expect(restaurant.restaurants[0].city, "Surabaya");
    expect(restaurant.restaurants[0].rating, 4.2);

    expect(restaurant.restaurants[1].id, "uewq1zg2zlskfw1e867");
    expect(restaurant.restaurants[1].name, "Kafein");
    expect(restaurant.restaurants[1].description,
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,");
    expect(restaurant.restaurants[1].pictureId, "15");
    expect(restaurant.restaurants[1].city, "Aceh");
    expect(restaurant.restaurants[1].rating, 4.6);
  });
}
