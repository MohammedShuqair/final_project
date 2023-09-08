import "package:final_project/core/util/colors.dart";
import "package:flutter/material.dart";

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar(
      {Key? key, required this.onSubmitted, required this.onCancel})
      : super(key: key);
  final void Function(String value) onSubmitted;
  final void Function() onCancel;
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController controller;
  late FocusNode focusNode;
  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onSubmitted: widget.onSubmitted,
      onChanged: (v) {
        setState(() {
          if (v.isEmpty) {
            widget.onCancel();
          }
        });
      },
      decoration: InputDecoration(
          hintText: "Search",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none),
          fillColor: controller.text.isNotEmpty ? kUnselect : kWhite,
          filled: true,
          prefixIcon: Icon(Icons.search),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      controller.clear();
                      focusNode.unfocus();
                      widget.onCancel();
                    });
                  },
                  icon: const Icon(Icons.cancel))
              : null),
    );
  }
}
