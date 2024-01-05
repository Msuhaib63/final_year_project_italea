import 'package:final_year_project_italea/Constant/color.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Module/Belajar/Category.dart';

class SearchTextField extends StatefulWidget {
  //final List<Category> category;

  const SearchTextField({
    Key? key,
    //required this.category,
  }) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController _searchController = TextEditingController();
  List<Category> filteredCategory = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      filteredCategory = categoryList.where((category) {
        final nameContainsQuery = category.name.toLowerCase().contains(query.toLowerCase());
        final categoryNumMatchesQuery = category.categoryNum.toString().contains(query);
        return nameContainsQuery || categoryNumMatchesQuery;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
          size: 26,
        ),
        suffixIcon: Icon(
          Icons.mic,
          color: hexStringToColor("00B4D8"),
          size: 26,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: "Search your topic",
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        isDense: true,
      ),
    );
  }
}