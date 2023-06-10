import 'dart:html';
import 'dart:js' as js;
import 'package:custom_search_page/service/http_util.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import '../service/app_get_it.dart';
import '../service/index_db.dart';
import '../service/store_key.dart';
import 'black_white_text_button.dart';

class EndSet extends StatefulWidget {
  const EndSet({
    super.key,
  });

  @override
  State<EndSet> createState() => _BackSetState();
}

class _BackSetState extends State<EndSet> {
  final IndexDB indexDB = appGetIt.get(instanceName: "IndexDB");
  final EventBus eventBus = appGetIt.get(instanceName: "EventBus");

  bool hasNewVersion = false;
  String localVersionHashString = '';
  String serverVersionHashString = '';

  Future<void> checkForUpdates() async {
    // 调用获取服务器上的版本号
    try {
      final serverVersion = await HttpUtil.getServerVersion();
      serverVersionHashString = serverVersion.toString();

      if (localVersionHashString.isEmpty) {
        // 首次启动的版本号，无须比较更新
        await indexDB.put(StoreKey.versionHashString, serverVersionHashString);
      } else if (serverVersionHashString.compareTo(localVersionHashString) != 0) {
        // 进行版本比较有更新
        debugPrint('old Version: $localVersionHashString \n new Version: $serverVersionHashString');
        setState(() {
          hasNewVersion = true;
        });
      }
    } catch (error) {
      debugPrint('Failed to fetch server version: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    localVersionHashString = indexDB.get(StoreKey.versionHashString) as String? ?? '';
    checkForUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlackWhiteTextButton(
          onPressed: () async {
            await indexDB.deleteAll();
            window.location.reload();
          },
          child: const SizedBox(
            width: 70.0,
            child: Text(
              '恢复初始化',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Visibility(
          visible: hasNewVersion,
          child: BlackWhiteTextButton(
          onPressed: () async {
            await js.context.callMethod('clearServiceWorkerCache');
            await indexDB.put(StoreKey.versionHashString, serverVersionHashString);
            window.location.reload();
          },
          child: const SizedBox(
            width: 70.0,
            child: Text(
              '更新版本',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        ),
      ],
    );
  }
}
