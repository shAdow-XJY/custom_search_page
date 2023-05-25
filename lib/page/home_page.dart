import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
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

  final openDialogNotifier = ValueNotifier<bool>(false);

  final isCustomBackImgNotifier = ValueNotifier<bool>(false);
  final customBackImgEncodeNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    subscription_1.cancel();
    subscription_2.cancel();
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
              CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    '${WebSiteLink.baseResourceLink}/assets/img/background.jpg',
                progressIndicatorBuilder: (context, str, downloadProgress) =>
                    Center(
                  child: LoadingBouncingGrid.square(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        return Image.memory(
                          base64Decode(customBackImgEncode),
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (context, object, stackTrace) =>
                              Container(
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
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
                    const CustomSearchBar(),
                  ],
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
