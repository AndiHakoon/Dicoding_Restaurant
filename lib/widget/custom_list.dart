import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant2/commons/theme.dart';
import 'package:restaurant2/data/model/restaurant.dart';
import 'package:restaurant2/provider/database_provider.dart';
import 'package:restaurant2/provider/preferences_provider.dart';
import 'package:restaurant2/ui/detail_page.dart';
import 'package:restaurant2/widget/toast.dart';

class CustomListItem extends StatelessWidget {
  final Restaurant restaurant;

  const CustomListItem({Key? key, required this.restaurant}) : super(key: key);

  static const _url = 'https://restaurant-api.dicoding.dev/images/small';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailPage.routeName,
        arguments: restaurant.id,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    '$_url/${restaurant.pictureId}',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.secondary,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null),
                      );
                    },
                    errorBuilder: (context, e, _) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: _Description(
                title: restaurant.name,
                location: restaurant.city,
                stars: restaurant.rating,
              ),
            ),
            FavButton(item: restaurant),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.title,
    required this.location,
    required this.stars,
  }) : super(key: key);

  final String title;
  final String location;
  final double stars;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: const Color(0xFFD74141),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.pin_drop, color: Colors.red),
              Text(
                location,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: const Color(0xFF4B4B4B),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.star, color: Color(0xFFFFD700)),
              Text(
                '$stars',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FavButton extends StatefulWidget {
  final Restaurant item;

  const FavButton({Key? key, required this.item}) : super(key: key);

  @override
  _FavButtonState createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, state, child) {
      return Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isFavorite(widget.item.id),
            builder: ((context, snapshot) {
              var isFavorite = snapshot.data ?? false;

              Icon iconSprite = isFavorite
                  ? const Icon(Icons.favorite, color: secondaryColor)
                  : const Icon(Icons.favorite_outline);

              return GestureDetector(
                onTap: () => setState(() {
                  isFavorite = !isFavorite;
                  if (isFavorite) {
                    provider.addFavorite(widget.item);
                    toast("Added");
                  } else {
                    provider.removeFavorite(widget.item.id);
                    toast("Removed");
                  }
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: iconSprite,
                ),
              );
            }),
          );
        },
      );
    });
  }
}
