import 'dart:ui';

import 'package:custom_search_page/component/search_set.dart';
import 'package:custom_search_page/component/style_set.dart';
import 'package:flutter/material.dart';
import '../component/back_set.dart';

class SettingDialog extends StatelessWidget {
  const SettingDialog({super.key});

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
              dragDevices: {
                PointerDeviceKind.touch,
              },
            ),
            child: const SingleChildScrollView(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '自定义设置',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SearchSet(),
                    StyleSet(),
                    BackSet(),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}