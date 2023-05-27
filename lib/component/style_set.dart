import 'package:custom_search_page/component/vertical_expand_animated_widget.dart';
import 'package:custom_search_page/service/store_key.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import '../service/app_get_it.dart';
import '../service/debounce.dart';
import '../service/events.dart';
import '../service/index_db.dart';
import 'common_set.dart';
import 'custom_drop_down.dart';
import 'hsv_color_picker.dart';

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

  final ValueNotifier<int> searchBarAlignOptionNotifier = ValueNotifier<int>(4);
  final List<String> searchBarAlignOptions = [
    '顶部左对齐（Top Left）',
    '顶部居中对齐（Top Center）',
    '顶部右对齐（Top Right）',
    '中部左对齐（Center Left）',
    '居中对齐（Center）',
    '中部右对齐（Center Right）',
    '底部左对齐（Bottom Left）',
    '底部居中对齐（Bottom Center）',
    '底部右对齐（Bottom Right）',
  ];

  final ValueNotifier<int> searchBarLengthOptionNotifier =
      ValueNotifier<int>(1);
  final List<String> searchBarLengthOptions = [
    '短（Short）',
    '中（Medium）',
    '长（Long）',
  ];

  final ValueNotifier<int> boxFitOptionNotifier = ValueNotifier<int>(3);
  final List<String> boxFitOptions = [
    '无（None）',
    '填充（Fill）',
    '缩放（Scale）',
    '覆盖（Cover）',
    '包含（Contain）',
    '适应宽度（Fit Width）',
    '适应高度（Fit Height）',
  ];

  final ValueNotifier<bool> lockOrCustomColorNotifier = ValueNotifier<bool>(false);

  final ValueNotifier<int> colorTypeOptionNotifier = ValueNotifier<int>(0);
  final List<String> colorTypeOptions = [
    '网页背景颜色',
    '设置按钮颜色',
    '搜索按钮颜色',
    '搜索栏文字颜色',
    '搜索栏边框颜色',
    '搜索栏背景颜色',
  ];

  final ValueNotifier<int> pickColorValueNotifier = ValueNotifier<int>(Colors.white.value);

  final Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  void dispatchColorValue(int colorValue) {
    pickColorValueNotifier.value = colorValue;
    if (!lockOrCustomColorNotifier.value) {
      return;
    }
    switch (colorTypeOptionNotifier.value) {
      case 0: {
        eventBus.fire(ChangePageBackColorEvent(colorValue: colorValue));
        indexDB.put(StoreKey.pageBackColorValue, colorValue);
        return;
      }
      case 1: {
        eventBus.fire(ChangeSettingBtnColorEvent(colorValue: colorValue));
        indexDB.put(StoreKey.settingBtnColorValue, colorValue);
        return;
      }
      case 2: {
        eventBus.fire(ChangeSearchBtnColorEvent(colorValue: colorValue));
        indexDB.put(StoreKey.searchBtnColorValue, colorValue);
        return;
      }
      case 3: {
        eventBus.fire(ChangeSearchBarTextColorEvent(colorValue: colorValue));
        indexDB.put(StoreKey.searchBarTextColorValue, colorValue);
        return;
      }
      case 4: {
        eventBus.fire(ChangeSearchBarBorderColorEvent(colorValue: colorValue));
        indexDB.put(StoreKey.searchBarBorderColorValue, colorValue);
        return;
      }
      case 5: {
        eventBus.fire(ChangeSearchBarBackColorEvent(colorValue: colorValue));
        indexDB.put(StoreKey.searchBarBackColorValue, colorValue);
        return;
      }
      default:
        return;
    }
  }

  int getColorValue() {
    int defaultColorValue = Colors.white.value;
    switch (colorTypeOptionNotifier.value) {
      case 0: {
        return indexDB.get(StoreKey.pageBackColorValue) as int? ?? defaultColorValue;
      }
      case 1: {
        return indexDB.get(StoreKey.settingBtnColorValue) as int? ?? defaultColorValue;
      }
      case 2: {
        return indexDB.get(StoreKey.searchBtnColorValue) as int? ?? Colors.deepPurpleAccent.value;
      }
      case 3: {
        return indexDB.get(StoreKey.searchBarTextColorValue) as int? ?? Colors.black.value;
      }
      case 4: {
        return indexDB.get(StoreKey.searchBarBorderColorValue) as int? ?? Colors.deepPurpleAccent.value;
      }
      case 5: {
        return indexDB.get(StoreKey.searchBarBackColorValue) as int? ?? defaultColorValue;
      }
      default:
        return defaultColorValue;
    }
  }

  @override
  void initState() {
    super.initState();
    searchBarAlignOptionNotifier.value =
        indexDB.get(StoreKey.searchBarAlignOption) as int? ?? 4;
    searchBarLengthOptionNotifier.value =
        indexDB.get(StoreKey.searchBarLengthOption) as int? ?? 1;
    boxFitOptionNotifier.value =
        indexDB.get(StoreKey.boxFitOption) as int? ?? 3;
    lockOrCustomColorNotifier.value =
        indexDB.get(StoreKey.lockOrCustomColor) as bool? ?? false;
    if (lockOrCustomColorNotifier.value) {
      pickColorValueNotifier.value = getColorValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonSet(title: '样式', children: [
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('搜索栏长度'),
          ValueListenableBuilder<int>(
            valueListenable: searchBarLengthOptionNotifier,
            builder: (context, searchBarLengthOption, child) {
              return CustomDropdown(
                items: searchBarLengthOptions,
                value: searchBarLengthOptions[searchBarLengthOption],
                onChanged: (String? newValue) {
                  final int temp = searchBarLengthOptions.indexOf(newValue!);
                  if (temp == searchBarLengthOption) {
                    return;
                  }
                  searchBarLengthOptionNotifier.value = temp;
                  eventBus.fire(ChangeSearchBarLengthOptionEvent(
                      searchBarLengthOption: temp));
                  indexDB.put(StoreKey.searchBarLengthOption, temp);
                },
              );
            },
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('搜索栏对齐'),
          ValueListenableBuilder<int>(
            valueListenable: searchBarAlignOptionNotifier,
            builder: (context, searchBarAlignOption, child) {
              return CustomDropdown(
                items: searchBarAlignOptions,
                value: searchBarAlignOptions[searchBarAlignOption],
                onChanged: (String? newValue) {
                  final int temp = searchBarAlignOptions.indexOf(newValue!);
                  if (temp == searchBarAlignOption) {
                    return;
                  }
                  searchBarAlignOptionNotifier.value = temp;
                  eventBus.fire(ChangeSearchBarAlignOptionEvent(
                      searchBarAlignOption: temp));
                  indexDB.put(StoreKey.searchBarAlignOption, temp);
                },
              );
            },
          ),
        ],
      ),
      ValueListenableBuilder<bool>(
        valueListenable: lockOrCustomColorNotifier,
        builder: (context, isCustomColor, child) {
          return Column(
            children: [
              CheckboxListTile(
                value: isCustomColor,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                secondary: isCustomColor ? Icon(Icons.lock_open, color: Theme.of(context).primaryColor,) : const Icon(Icons.lock),
                title: const Text('自定义颜色'),
                onChanged: (value) {
                  lockOrCustomColorNotifier.value = value!;
                  indexDB.put(StoreKey.lockOrCustomColor, value);
                  if (value) {
                    pickColorValueNotifier.value = getColorValue();
                  }
                },
              ),
              Visibility(
                visible: isCustomColor,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: VerticalExpandAnimatedWidget(
                  isExpanded: isCustomColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('选择对象'),
                      ValueListenableBuilder<int>(
                        valueListenable: colorTypeOptionNotifier,
                        builder: (context, colorTypeOption, child) {
                          return CustomDropdown(
                            items: colorTypeOptions,
                            value: colorTypeOptions[colorTypeOption],
                            onChanged: (String? newValue) {
                              final int temp = colorTypeOptions.indexOf(newValue!);
                              if (temp == colorTypeOption) {
                                return;
                              }
                              colorTypeOptionNotifier.value = temp;
                              pickColorValueNotifier.value = getColorValue();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      const SizedBox(height: 5.0,),
      ValueListenableBuilder<int>(
        valueListenable: pickColorValueNotifier,
        builder: (context, pickColorValue, child) {
          return HSVColorPicker(
            pickerColor: Color(pickColorValue),
            onColorChanged: (Color color) {
              debouncer.debounce(() => dispatchColorValue(color.value));
            },
          );
        },
      ),
    ]);
  }
}
