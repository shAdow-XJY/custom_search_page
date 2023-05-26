import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_search_page/component/animation_opacity.dart';
import 'package:custom_search_page/page/custom_search_bar.dart';
import 'package:custom_search_page/page/setting_dialog.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import '../service/app_get_it.dart';
import '../service/events.dart';
import '../service/index_db.dart';
import '../service/store_key.dart';
import '../service/website_link.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EventBus eventBus = appGetIt.get(instanceName: "EventBus");
  final IndexDB indexDB = appGetIt.get(instanceName: "IndexDB");
  late StreamSubscription subscription_1;
  late StreamSubscription subscription_2;
  late StreamSubscription subscription_3;
  late StreamSubscription subscription_4;

  final ValueNotifier<bool> openDialogNotifier = ValueNotifier<bool>(false);

  final ValueNotifier<bool> isCustomBackImgNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<String> customBackImgEncodeNotifier =
      ValueNotifier<String>('');

  final ValueNotifier<int> boxFitOptionNotifier = ValueNotifier<int>(3);
  final List<BoxFit> boxFitList = [
    BoxFit.none,
    BoxFit.fill,
    BoxFit.scaleDown,
    BoxFit.cover,
    BoxFit.contain,
    BoxFit.fitWidth,
    BoxFit.fitHeight
  ];

  final ValueNotifier<int> searchBarOptionNotifier = ValueNotifier<int>(1);
  final List<Alignment> searchBarOptions = [
    Alignment.topCenter,
    Alignment.center,
    Alignment.bottomCenter
  ];

  @override
  void initState() {
    super.initState();
    searchBarOptionNotifier.value =
        indexDB.get(StoreKey.searchBarOption) as int? ?? 1;
    boxFitOptionNotifier.value =
        indexDB.get(StoreKey.boxFitOption) as int? ?? 3;
    customBackImgEncodeNotifier.value =
        indexDB.get(StoreKey.customBackImgEncode) as String? ?? '';
    isCustomBackImgNotifier.value =
        indexDB.get(StoreKey.isCustomBackImg) as bool? ?? false;
    subscription_1 = eventBus.on<ChangeBackImgEvent>().listen((event) {
      customBackImgEncodeNotifier.value = event.imgEncode;
    });
    subscription_2 = eventBus.on<ChangeIsCustomBackImgEvent>().listen((event) {
      isCustomBackImgNotifier.value = event.isCustomBackImg;
    });
    subscription_3 = eventBus.on<ChangeBoxFitEvent>().listen((event) {
      boxFitOptionNotifier.value = event.boxFitOption;
    });
    subscription_4 = eventBus.on<ChangeSearchBarOptionEvent>().listen((event) {
      searchBarOptionNotifier.value = event.searchBarOption;
    });
  }

  @override
  void dispose() {
    subscription_1.cancel();
    subscription_2.cancel();
    subscription_3.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: isCustomBackImgNotifier,
                builder: (context, isCustomBackImg, child) {
                  return Visibility(
                    visible: !isCustomBackImg,
                    maintainState: true,
                    child: ValueListenableBuilder<int>(
                      valueListenable: boxFitOptionNotifier,
                      builder: (context, boxFitOption, child) {
                        return CachedNetworkImage(
                          fit: boxFitList[boxFitOption],
                          filterQuality: FilterQuality.high,
                          imageUrl:
                              '${WebSiteLink.baseResourceLink}/assets/img/background.jpg',
                          progressIndicatorBuilder:
                              (context, str, downloadProgress) => Center(
                            child: LoadingBouncingGrid.square(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                      },
                    ),
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isCustomBackImgNotifier,
                builder: (context, isCustomBackImg, child) {
                  return Visibility(
                    visible: isCustomBackImg,
                    maintainState: true,
                    child: ValueListenableBuilder<String>(
                      valueListenable: customBackImgEncodeNotifier,
                      builder: (context, customBackImgEncode, child) {
                        return ValueListenableBuilder<int>(
                          valueListenable: boxFitOptionNotifier,
                          builder: (context, boxFitOption, child) {
                            return AnimationOpacity(
                              isShow: isCustomBackImg,
                              child: Image.memory(
                                base64Decode(customBackImgEncode),
                                fit: boxFitList[boxFitOption],
                                filterQuality: FilterQuality.high,
                                errorBuilder: (context, object, stackTrace) =>
                                    Container(color: Colors.grey),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: searchBarOptionNotifier,
                builder: (context, searchBarOption, child) {
                  return Align(
                    alignment: searchBarOptions[searchBarOption],
                    child: const SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 130.0, horizontal: 50.0),
                      child: CustomSearchBar(),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          openDialogNotifier.value =
                          !openDialogNotifier.value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: openDialogNotifier,
                builder: (context, isOpenDialog, child) {
                  return Visibility(
                    visible: isOpenDialog,
                    maintainState: true, // 保持子组件的状态
                    child: const SettingDialog(),
                  );
                },
              ),
            ],
          )),
    );
  }
}
