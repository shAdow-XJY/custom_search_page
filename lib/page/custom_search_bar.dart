import 'dart:async';
import 'dart:html' as html;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import '../service/app_get_it.dart';
import '../service/events.dart';
import '../service/index_db.dart';
import '../service/store_key.dart';
import '../service/website_link.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final IndexDB indexDB = appGetIt.get(instanceName: "IndexDB");
  final EventBus eventBus = appGetIt.get(instanceName: "EventBus");
  late StreamSubscription subscription_1;

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

  bool isJumpToNewPage = false;
  int engineOption = 0;

  void _search(String query) {
    if (isJumpToNewPage) {
      html.AnchorElement anchorElement = html.AnchorElement(href: engineUrl[engineOption] + query);
      anchorElement.target = '_blank';
      anchorElement.click();
    } else {
      html.window.location.href = engineUrl[engineOption] + query;
    }
  }

  @override
  void initState() {
    super.initState();
    engineOption = indexDB.get(StoreKey.engineOption) as int? ?? 0;
    isJumpToNewPage = indexDB.get(StoreKey.isJumpToNewPage) as bool? ?? false;
    subscription_1 = eventBus.on<ChangeIsJumpToNewPageEvent>().listen((event) {
      isJumpToNewPage = event.isJumpToNewPage;
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    subscription_1.cancel();
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
              tooltip: engineName[engineOption],
              hoverColor: Colors.transparent,
              icon: Image(image: CachedNetworkImageProvider('${WebSiteLink.baseResourceLink}/assets/icon/${engineName[engineOption]}.png',)),
              onPressed: () {
                setState(() {
                  engineOption = (engineOption + 1) % 3;
                });
                indexDB.put(StoreKey.engineOption, engineOption);
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