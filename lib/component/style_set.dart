import 'package:custom_search_page/service/store_key.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import '../service/app_get_it.dart';
import '../service/events.dart';
import '../service/index_db.dart';
import 'common_set.dart';
import 'custom_drop_down.dart';

class StyleSet extends StatefulWidget {
  const StyleSet({
    super.key,
  });

  @override
  State<StyleSet> createState() => _BackSetState();
}

class _BackSetState extends State<StyleSet> {
  final IndexDB indexDB = appGetIt.get(instanceName: "IndexDB");
  final EventBus eventBus = appGetIt.get(instanceName: "EventBus");

  final ValueNotifier<int> searchBarOptionNotifier = ValueNotifier<int>(1);
  final List<String> searchBarOptions = ['顶部（Top）', '居中（Center）', '底部（Bottom）'];

  final ValueNotifier<int> boxFitOptionNotifier = ValueNotifier<int>(3);
  final List<String> boxFitOptions = ['无（None）', '填充（Fill）', '缩放（Scale）', '覆盖（Cover）', '包含（Contain）', '适应宽度（Fit Width）', '适应高度（Fit Height）'];

  @override
  void initState() {
    super.initState();
    searchBarOptionNotifier.value =
        indexDB.get(StoreKey.searchBarOption) as int? ?? 1;
    boxFitOptionNotifier.value =
        indexDB.get(StoreKey.boxFitOption) as int? ?? 3;
  }

  @override
  Widget build(BuildContext context) {
    return CommonSet(title: '样式', children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('搜索栏'),
          ValueListenableBuilder<int>(
            valueListenable: searchBarOptionNotifier,
            builder: (context, searchBarOption, child) {
              return CustomDropdown(
                items: searchBarOptions,
                value: searchBarOptions[searchBarOption],
                onChanged: (String? newValue) {
                  final int temp = searchBarOptions.indexOf(newValue!);
                  if (temp == searchBarOption) {
                    return;
                  }
                  searchBarOptionNotifier.value = temp;
                  eventBus.fire(ChangeSearchBarOptionEvent(searchBarOption: temp));
                  indexDB.put(StoreKey.searchBarOption, temp);
                },
              );
            },
          ),

        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('背景图片'),
          ValueListenableBuilder<int>(
            valueListenable: boxFitOptionNotifier,
            builder: (context, boxFitOption, child) {
              return CustomDropdown(
                items: boxFitOptions,
                value: boxFitOptions[boxFitOption],
                onChanged: (String? newValue) {
                  final int temp = boxFitOptions.indexOf(newValue!);
                  if (temp == boxFitOption) {
                    return;
                  }
                  boxFitOptionNotifier.value = temp;
                  eventBus.fire(ChangeBoxFitEvent(boxFitOption: temp));
                  indexDB.put(StoreKey.boxFitOption, temp);
                },
              );
            },
          ),

        ],
      ),
    ]);
  }
}
