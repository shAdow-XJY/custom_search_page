import 'dart:html';

import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchTextController = TextEditingController();

  void _search(String query) {
    // 搜索引擎URL
    String googleUrl = 'https://www.google.com/search?q=$query';
    String bingUrl = 'https://www.bing.com/search?q=$query';
    String duckDuckGoUrl = 'https://duckduckgo.com/?q=$query';

    window.location.href = bingUrl;
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
      child: TextField(
        controller: _searchTextController,
        decoration: const InputDecoration(
          labelText: 'Enter your search query',
        ),
        onSubmitted: (String inputQuery) {
          _search(inputQuery);
        },
      ),
    );
  }
}