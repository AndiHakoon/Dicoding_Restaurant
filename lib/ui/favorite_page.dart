import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant2/data/model/restaurant.dart';
import 'package:restaurant2/provider/database_provider.dart';
import 'package:restaurant2/utils/result_state.dart';
import 'package:restaurant2/widget/custom_list.dart';

class FavoritePage extends StatefulWidget {
  static String favoriteTitle = 'Favorites';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<SearchResult> restaurantSearch;

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildRestaurantItem() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.hasData) {
        return Expanded(
          child: ListView.builder(
            itemCount: provider.favorites.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var restaurant = provider.favorites[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: CustomListItem(restaurant: restaurant),
              );
            },
          ),
        );
      } else {
        return Expanded(child: Center(child: Text(provider.message)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Text('FAVORITES',
              style: GoogleFonts.poppins(
                color: const Color(0xFFFF4747),
                fontWeight: FontWeight.bold,
                fontSize: 28,
              )),
        ),
        _buildRestaurantItem()
      ],
    );
  }
}
