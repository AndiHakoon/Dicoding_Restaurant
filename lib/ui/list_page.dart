import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant2/data/api/api_service.dart';
import 'package:restaurant2/data/model/restaurant.dart';
import 'package:restaurant2/provider/restaurant_provider.dart';
import 'package:restaurant2/utils/result_state.dart';
import 'package:restaurant2/widget/custom_list.dart';
import 'package:restaurant2/widget/custom_search.dart';

class ListPage extends StatefulWidget {
  static String routeName = '/list_page';

  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Restaurant> restaurants = [];
  late Future<SearchResult> restaurantSearch;
  String query = '';
  Timer? debouncer;

  String url = 'assets/local_restaurant.json';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  void searchRestaurant(String query) async => debounce(() async {
        final client = Client();
        restaurantSearch = ApiService(client).search(query);

        if (!mounted) return;
        setState(() {
          this.query = query;
        });
      });

  Widget buildSearch() => SearchWidget(
        hintText: 'Search name or city',
        text: query,
        onChanged: searchRestaurant,
      );

  Widget _buildRestaurantItem() {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.hasData) {
        var restaurants = state.result.restaurants;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = restaurants[index];
            return CustomListItem(restaurant: restaurant);
          },
        );
      } else if (state.state == ResultState.noData) {
        return Center(child: Text(state.message));
      } else {
        return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.error,
              size: 30,
              color: Color(0xFFBDBDBD),
            ),
            Text(
              'Something Went wrong!!!',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ]),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RESTAURANT YOI',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFD74141),
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      )),
                  Text(
                    'Recommendation restaurant for you!',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: buildSearch(),
                ),
              ],
            ),
            query == ""
                ? Flexible(
                    child: _buildRestaurantItem(),
                  )
                : FutureBuilder(
                    future: restaurantSearch,
                    builder: (context, AsyncSnapshot<SearchResult> snapshot) {
                      var state = snapshot.connectionState;
                      if (state == ConnectionState.waiting) {
                        return const Expanded(
                            child: Center(child: CircularProgressIndicator()));
                      } else if (state == ConnectionState.done) {}
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.restaurants.length,
                            itemBuilder: (context, index) {
                              var restaurant =
                                  snapshot.data!.restaurants[index];
                              return CustomListItem(restaurant: restaurant);
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error,
                                  size: 30,
                                  color: Color(0xFF4B4B4B),
                                ),
                                Text(
                                  'Something Went wrong!!!',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ]),
                        );
                      }
                      return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error,
                                size: 30,
                                color: Color(0xFF4B4B4B),
                              ),
                              Text(
                                'Something Went wrong!!!',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
