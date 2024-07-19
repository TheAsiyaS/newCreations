import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataItem {
  int value;
  DataItem(this.value);
}

// ignore: must_be_immutable
class DataList extends StatelessWidget {
  ValueNotifier<List<DataItem>> list =
      ValueNotifier(List.generate(10, (index) => DataItem(0)));

  DataList({super.key});
  @override
  Widget build(BuildContext context) {
    log('length :${list.value.length}');

    return ListView.builder(
      itemCount: list.value.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item ${index + 1}'),
          trailing: ValueListenableBuilder<List<DataItem>>(
              valueListenable: list,
              builder: (context, value, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${list.value[index].value}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        list.value[index].value++;
                        list.value = List.from(list.value);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (list.value[index].value > 0) {
                          list.value[index].value--;
                          list.value = List.from(list.value);
                        }
                      },
                    ),
                  ],
                );
              }),
        );
      },
    );
  }
}
