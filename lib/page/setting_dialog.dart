import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import '../service/app_get_it.dart';
import '../service/events.dart';
import '../service/image_loader.dart';
import '../service/index_db.dart';
import '../service/store_key.dart';

class SettingDialog extends StatefulWidget {
  const SettingDialog({super.key});

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {

  final IndexDB indexDB = appGetIt.get(instanceName: "IndexDB");
  final EventBus eventBus = appGetIt.get(instanceName: "EventBus");

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.only(right: 20.0, top: 40.0, bottom: 40.0),
      alignment: Alignment.topRight,
      child: SingleChildScrollView(
        child: SizedBox(
            width: 360,
            height: 600,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    ImageLoader.selectAndSetBackgroundImage().then((map) => {
                      if(map['isSelected']) {
                        eventBus.fire(ChangeBackImgEvent(imgEncode: map['imgEncode'])),
                        indexDB.put(StoreKey.customBackImgEncode, map['imgEncode']),
                      }
                    });
                    },
                )
              ],
            )
        ),
      ),
    );
  }
}