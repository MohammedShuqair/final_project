import "package:flutter/material.dart";

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key, required this.onSubmitted})
      : super(key: key);
  final void Function(String value) onSubmitted;
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
          labelText: "Search",
          suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: const Icon(Icons.cancel))),
    );
  }
}
