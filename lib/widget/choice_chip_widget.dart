import 'package:flutter/material.dart';

class ChipsFilter extends StatefulWidget {
  final List<Filter> filters;
  final int selected;
  final Function() onTap;

  String get selectedItem {
    return selected.toString();
  }

  const ChipsFilter({
    Key? key,
    required this.filters,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  _ChipsFilterState createState() => _ChipsFilterState();
}

class _ChipsFilterState extends State<ChipsFilter> {
  var selectedIndex = 0;

  // Build a chip
  Widget chipBuilder(context, currentIndex) {
    Filter filter = widget.filters[currentIndex];
    bool active = selectedIndex == currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = currentIndex;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFFF4747) : const Color(0xFFFFEDED),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              filter.label,
              style: TextStyle(
                fontSize: 12,
                color: active ? Colors.white : const Color(0xFFFF4747),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // When [widget.selected] is defined, check the value and set it as
    // [selectedIndex]
    if (widget.selected >= 0 && widget.selected < widget.filters.length) {
      selectedIndex = widget.selected;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.filters.length,
      itemBuilder: chipBuilder,
      scrollDirection: Axis.horizontal,
    );
  }
}

class Filter {
  final String label;

  const Filter({required this.label});
}
