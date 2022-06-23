import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant2/data/api/api_service.dart';
import 'package:restaurant2/data/model/detail.dart';
import 'package:restaurant2/provider/restaurant_provider.dart';
import 'package:restaurant2/utils/constants.dart';
import 'package:restaurant2/utils/result_state.dart';
import 'package:restaurant2/widget/item_bar.dart';

class DetailPage extends StatefulWidget {
  static const String routeName = "/detail";
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var idSelected = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(
          id: widget.id, query: null, apiService: ApiService(Client())),
      child: _renderView(),
    );
  }

  Row listChip(Menus menu) {
    foods.addAll(menu.foods);
    drinks.addAll(menu.drinks);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: chipBarList
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Text(item.title),
                selected: idSelected == item.id,
                onSelected: (_) => setState(() => idSelected = item.id),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _actionButton(BuildContext context, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 21, left: 21),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  Widget _renderView() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        switch (state.state) {
          case ResultState.loading:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Loading"),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          case ResultState.hasData:
            return Scaffold(body: _detailView(state.detail.detail));
          case ResultState.noData:
            return Container();
          case ResultState.error:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Sepertinya ada masalah.."),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.error, size: 50),
                    Text("Sepertinya ada masalah.."),
                  ],
                ),
              ),
            );
        }
      },
    );
  }

  Widget currentTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: chipBarList[idSelected].bodyWidget,
    );
  }

  Widget _detailView(Detail restaurant) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    '$imageUrl/${restaurant.pictureId}',
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: _actionButton(
                    context,
                    () => Navigator.pop(context),
                  ),
                ),
                const Positioned(
                  top: 0,
                  right: 0,
                  child: _FavoriteButton(),
                ),
                Container(
                  height: 21,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(52),
                      topRight: Radius.circular(52),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: GoogleFonts.poppins(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.25,
                            color: const Color(0xFFD74141),
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            const Icon(Icons.pin_drop, color: Colors.red),
                            Text(restaurant.city,
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                        Text(
                          restaurant.address,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(Icons.star,
                            size: 43, color: Color(0xFFFFD700)),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deskripsi",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 21),
                  Text(
                    "Menu",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: listChip(restaurant.menus),
            ),
            currentTab(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        isFavorited = !isFavorited;
      }),
      child: Padding(
        padding: const EdgeInsets.only(top: 21, right: 21),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: isFavorited
              ? Icon(
                  Icons.favorite,
                  color: Theme.of(context).iconTheme.color,
                )
              : Icon(
                  Icons.favorite_outline,
                  color: Theme.of(context).iconTheme.color,
                ),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
