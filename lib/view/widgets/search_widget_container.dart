import 'package:flutter/material.dart';

class SearchWidgetContainer extends StatelessWidget {
  final String hintText;
  final VoidCallback onTap;

  const SearchWidgetContainer(
      {Key? key, required this.hintText, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColorLight),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hintText,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Poppins",
                        color: Theme.of(context).primaryColorLight)),
                Icon(Icons.search, color: Theme.of(context).primaryColorLight)
              ],
            )),
      ),
    );
  }
}
