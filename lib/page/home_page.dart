import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:custom_search_page/page/custom_search_bar.dart';
import 'package:custom_search_page/page/setting_dialog.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import '../service/app_get_it.dart';
import '../service/events.dart';
import '../service/index_db.dart';
import '../service/store_key.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final EventBus eventBus = appGetIt.get(instanceName: "EventBus");
  final IndexDB indexDB = appGetIt.get(instanceName: "IndexDB");
  late StreamSubscription subscription_1;

  bool isCustomBackImg = false;
  Uint8List customBackImgBytes = Uint8List(0);

  Future<void> initAsync() async {
    // 获取 get 方法的值
    final isCustomBackImgValue = await indexDB.get(StoreKey.isCustomBackImg);
    final customBackImgEncodeValue = await indexDB.get(StoreKey.customBackImgEncode);

    setState(() {
      // 根据获取的值更新状态
      isCustomBackImg = isCustomBackImgValue as bool? ?? false;
      customBackImgBytes = base64Decode(customBackImgEncodeValue as String? ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    // isCustomBackImg = indexDB.get(StoreKey.isCustomBackImg) as bool;
    // customBackImgBytes = base64Decode(indexDB.get(StoreKey.customBackImgEncode) as String);
    initAsync();
    subscription_1 = eventBus.on<ChangeBackImgEvent>().listen((event) {
      setState(() {
        customBackImgBytes = base64Decode(event.imgEncode);
      });
    });
  }

  @override
  void dispose() {
    subscription_1.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(customBackImgBytes),//AssetImage('assets/img/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SettingDialog();
                        },
                      );
                    },
                  ),
                ],
              ),
              CustomSearchBar(),
            ],
          ),
        ),
      ),
    );
  }

}
