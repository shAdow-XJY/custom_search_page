
import 'dart:html';

import 'package:custom_search_page/component/search_set.dart';
import 'package:custom_search_page/component/style_set.dart';
import 'package:flutter/material.dart';
import '../component/back_set.dart';
import '../service/app_get_it.dart';
import '../service/index_db.dart';

class SettingDialog extends StatelessWidget {
  SettingDialog({super.key});

  final IndexDB indexDB = appGetIt.get(instanceName: "IndexDB");

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.topRight,
      insetPadding: const EdgeInsets.only(right: 20.0, top: 40.0, bottom: 40.0),
      surfaceTintColor: Colors.deepPurple,
      child: Container(
          width: 360,
          height: 600,
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
              // dragDevices: {
              //   PointerDeviceKind.touch,
              // },
            ),
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '自定义设置',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    const SearchSet(),
                    const BackSet(),
                    const StyleSet(),
                    Align(
                      child: TextButton(
                        onPressed: () async {
                          await indexDB.deleteAll();
                          window.location.reload();
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.resolveWith<BorderSide>((Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                              return const BorderSide(color: Colors.white);
                            }
                            return const BorderSide(color: Colors.black);
                          }),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
                          overlayColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                              return Colors.black;
                            }
                            return Colors.white;
                          }),
                          foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            }
                            return Colors.black;
                          }),
                        ),
                        child: const Text(
                          '恢复初始化',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}