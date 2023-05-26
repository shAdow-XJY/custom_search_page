import 'dart:convert';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import '../service/app_get_it.dart';
import '../service/events.dart';
import '../service/image_loader.dart';
import '../service/index_db.dart';
import '../service/store_key.dart';
import 'common_set.dart';

class SearchSet extends StatefulWidget {
  const SearchSet({
    super.key,
  });

  @override
  State<SearchSet> createState() => _BackSetState();
}

class _BackSetState extends State<SearchSet> {
  final IndexDB indexDB = appGetIt.get(instanceName: "IndexDB");
  final EventBus eventBus = appGetIt.get(instanceName: "EventBus");

  final ValueNotifier<bool> isJumpToNewPageNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    isJumpToNewPageNotifier.value = indexDB.get(StoreKey.isJumpToNewPage) as bool? ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return CommonSet(title: '搜索', children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('跳转新页面'),
          ValueListenableBuilder<bool>(
            valueListenable: isJumpToNewPageNotifier,
            builder: (context, isJumpToNewPage, child) {
              return Switch(
                value: isJumpToNewPage,
                onChanged: (value) {
                  isJumpToNewPageNotifier.value = value;
                  eventBus.fire(ChangeIsJumpToNewPageEvent(isJumpToNewPage: value));
                  indexDB.put(StoreKey.isJumpToNewPage, value);
                },
              );
            },
          ),
        ],
      ),
    ]);
  }
}
