import 'dart:html';

import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  final TextEditingController _searchTextController = TextEditingController();

  // 搜索引擎URL
  List<String> engineUrl = [
    'https://www.bing.com/search?q=',
    'https://www.google.com/search?q=',
    'https://baidu.com/s?wd=',
  ];
  List<String> engineName = [
    'bing',
    'google',
    'baidu',
  ];

  int engineIndex = 0;

  void _search(String query) {
    window.location.href = engineUrl[engineIndex] + query;
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _searchTextController,
        decoration: InputDecoration(
          hintText: 'Enter your search query',
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 15.0), // Adjust the right padding here
            child: IconButton(
              tooltip: engineName[engineIndex],
              hoverColor: Colors.transparent,
              icon: Image.asset('asset/icon/${engineName[engineIndex]}.png'),
              onPressed: () {
                setState(() {
                  engineIndex = (engineIndex + 1) % 3;
                });
              },
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 15.0), // Adjust the right padding here
            child: IconButton(
              tooltip: 'search',
              hoverColor: Colors.transparent,
              icon: const Icon(Icons.search_rounded),
              onPressed: () {
                _search(_searchTextController.text);
              },
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onFieldSubmitted: (String inputQuery) {
          _search(inputQuery);
        },
      ),
    );
  }
}