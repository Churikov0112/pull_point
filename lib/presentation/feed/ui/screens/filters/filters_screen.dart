import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

class FeedFiltersScreen extends StatelessWidget {
  const FeedFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Фильтры")),
      body: Column(
        children: [
          IconButton(
            onPressed: () async {
              // TimeRange result = await showTimeRangePicker(
              //   context: context,
              // );
            },
            icon: const Icon(Icons.watch),
          )
        ],
      ),
    );
  }
}
