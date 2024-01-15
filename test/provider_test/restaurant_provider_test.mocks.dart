// ignore_for_file: no_leading_underscores_for_library_prefixes, camel_case_types, use_super_parameters, override_on_non_overriding_member

import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:sida_mangan/data/model/restaurant_model.dart' as _i2;
import 'package:sida_mangan/data/model/search_restaurant_model.dart' as _i4;
import 'package:sida_mangan/utils/result_state.dart' as _i7;

import 'restaurant_provider_test.dart' as _i5;

class _FakeRestaurantResult_0 extends _i1.SmartFake
    implements _i2.RestaurantsModel {
  _FakeRestaurantResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRestaurantSearchResult_2 extends _i1.SmartFake
    implements _i4.SearchRestaurantModel {
  _FakeRestaurantSearchResult_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class MockApiServiceTest extends _i1.Mock implements _i5.ApiServiceTest {
  MockApiServiceTest() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.RestaurantsModel> listRestaurant() => (super.noSuchMethod(
        Invocation.method(
          #listRestaurant,
          [],
        ),
        returnValue:
            _i6.Future<_i2.RestaurantsModel>.value(_FakeRestaurantResult_0(
          this,
          Invocation.method(
            #listRestaurant,
            [],
          ),
        )),
      ) as _i6.Future<_i2.RestaurantsModel>);

  @override
  String picture(
    String? pictureId,
    _i7.PictureSize? pictureSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #picture,
          [
            pictureId,
            pictureSize,
          ],
        ),
        returnValue: '',
      ) as String);
  @override
  _i6.Future<_i4.SearchRestaurantModel> searchRestaurant(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchRestaurant,
          [query],
        ),
        returnValue: _i6.Future<_i4.SearchRestaurantModel>.value(
            _FakeRestaurantSearchResult_2(
          this,
          Invocation.method(
            #searchRestaurant,
            [query],
          ),
        )),
      ) as _i6.Future<_i4.SearchRestaurantModel>);
}
