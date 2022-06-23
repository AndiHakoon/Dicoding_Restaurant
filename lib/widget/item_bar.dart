import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/model/detail.dart';

class ItemChipBar {
  final int id;
  final Widget bodyWidget;
  final String title;

  ItemChipBar(this.id, this.title, this.bodyWidget);

}

final List<Item> foods = [];
final List<Item> drinks = [];

final chipBarList = <ItemChipBar>[
  ItemChipBar(
      0,
      'Foods',
      Table(
          children: foods
              .map((item) => TableRow(
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.circle, size: 10, color: Color(0xFFD74141)),
                          Text(
                            item.name,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          )
                        ],
                      )
                    ],
                  ))
              .toList())),
  ItemChipBar(
      1,
      'Drinks',
      Table(
          children: drinks
              .map((item) => TableRow(
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.circle, size: 10, color: Color(0xFFD74141)),
                          Text(
                            item.name,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          )
                        ],
                      )
                    ],
                  ))
              .toList())),
];
