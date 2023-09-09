import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TagTiles extends StatefulWidget {
  static const String id = "/tagTiles";

  const TagTiles({super.key});

  @override
  State<TagTiles> createState() => _TagTilesState();
}

class _TagTilesState extends State<TagTiles> {
  List<String> tags = [
    '#Urgent',
    '#Egyptian Military',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 56,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/hashtag.svg',
                width: 18.0,
                height: 28.0,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tags.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Text(
                      tags[index] + "  ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,),
                    );
                  },
                ),
              ),

              Spacer(),
              SvgPicture.asset(
                'assets/icons/arrow_gray.svg',
                width: 18.0,
                height: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
