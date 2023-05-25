import 'package:custom_search_page/service/store_key.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import '../service/app_get_it.dart';
import '../service/events.dart';
import '../service/index_db.dart';
import 'common_set.dart';

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

  int _boxFitOption = 0;
  final List<String> _options = ['无（None）', '填充（Fill）', '缩放（Scale）', '覆盖（Cover）', '包含（Contain）', '适应宽度（Fit Width）', '适应高度（Fit Height）'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonSet(title: '样式', children: [
      Container(
        margin: const EdgeInsets.only(top: 15.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          focusColor: Colors.transparent,
          value: _options[_boxFitOption],
          onChanged: (String? newValue) {
            final int temp = _options.indexOf(newValue!);
            if (temp == _boxFitOption) {
              return;
            }
            setState(() {
              _boxFitOption = temp;
            });
            eventBus.fire(ChangeBoxFitEvent(boxFitOption: _boxFitOption));
            indexDB.put(StoreKey.boxFitOption, _boxFitOption);
          },
          underline: const SizedBox.shrink(),
          items: _options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              alignment: AlignmentDirectional.center,
              child: Text(value),
            );
          }).toList(),
        ),
      )
    ]);
  }
}
