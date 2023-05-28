import 'dart:convert';
import 'dart:html';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import '../service/app_get_it.dart';
import '../service/events.dart';
import '../service/image_loader.dart';
import '../service/index_db.dart';
import '../service/store_key.dart';
import 'common_set.dart';

class BackSet extends StatefulWidget {
  const BackSet({
    super.key,
  });

  @override
  State<BackSet> createState() => _BackSetState();
}

class _BackSetState extends State<BackSet> {
  final IndexDB indexDB = appGetIt.get(instanceName: "IndexDB");
  final EventBus eventBus = appGetIt.get(instanceName: "EventBus");

  final ValueNotifier<bool> isCustomBackImgNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<String> customBackImgEncodeNotifier =
      ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    isCustomBackImgNotifier.value =
        indexDB.get(StoreKey.isCustomBackImg) as bool? ?? false;
    customBackImgEncodeNotifier.value =
        indexDB.get(StoreKey.customBackImgEncode) as String? ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return CommonSet(
      title: '背景',
      clearCallback: () async {
        await indexDB.delete(StoreKey.isCustomBackImg);
        await indexDB.delete(StoreKey.customBackImgEncode);
        window.location.reload();
      },
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: isCustomBackImgNotifier,
          builder: (context, isCustomBackImg, child) {
            return CheckboxListTile(
              value: isCustomBackImg,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              title: const Text('自定义背景图片'),
              onChanged: (value) {
                isCustomBackImgNotifier.value = value!;
                Future.delayed(const Duration(milliseconds: 300), () {
                  eventBus
                      .fire(ChangeIsCustomBackImgEvent(isCustomBackImg: value));
                  indexDB.put(
                      StoreKey.isCustomBackImg, isCustomBackImgNotifier.value);
                });
              },
            );
          },
        ),
        InkWell(
          onTap: () {
            ImageLoader.selectAndSetBackgroundImage().then((String? imgEncode) {
              if (imgEncode != null) {
                customBackImgEncodeNotifier.value = imgEncode;
                Future.delayed(const Duration(milliseconds: 300), () {
                  eventBus.fire(ChangeBackImgEvent(imgEncode: imgEncode));
                  indexDB.put(StoreKey.customBackImgEncode, imgEncode);
                });
              }
            });
          },
          child: ValueListenableBuilder<String>(
            valueListenable: customBackImgEncodeNotifier,
            builder: (context, customBackImgEncode, child) {
              return Image.memory(
                base64Decode(customBackImgEncode),
                height: 200,
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, object, stackTrace) => Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image),
                      Text('选择本地图片'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
