import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Constant/color.dart';

class CustomTabView extends StatefulWidget {

  final int noOfSubTopic;
  final Function(int) changeTab;
  final int index;

  const CustomTabView({
    Key? key,
    required this.changeTab,
    required this.index,
    required this.noOfSubTopic,
  })
      : super(key: key);

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  late final List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = ["Playlist (${widget.noOfSubTopic.toString()})" , "Description"];
  }

  Widget _buildTags(int index) {
    return GestureDetector(
      onTap: () {
        widget.changeTab(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .12, vertical: 15),
        decoration: BoxDecoration(
          color: widget.index == index ? hexStringToColor("03045E") : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          _tags[index],
          style: TextStyle(
            color: widget.index != index ? hexStringToColor("03045E") : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .08, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          //color: Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the Row
          children: _tags
              .asMap()
              .entries
              .map((MapEntry map) => _buildTags(map.key))
              .toList(),
        ),
      ),
    );
  }
}