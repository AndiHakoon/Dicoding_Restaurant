import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget(
      {Key? key,
      required this.text,
      required this.onChanged,
      required this.hintText})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();

}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle();
    final styleHint = TextStyle();
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 43,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : Icon(null),
          hintText: widget.hintText,
          hintStyle: style,
        ),

        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
