import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

class MapFiltersScreen extends StatelessWidget {
  const MapFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Фильтры")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Дата",
              style: TextStyle(fontSize: 24),
            ),
            IconButton(
              onPressed: () async {
                final result = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 7),
                  ),
                );
                print(result);
              },
              icon: const Icon(Icons.calendar_month),
            ),
            const Text(
              "Время",
              style: TextStyle(fontSize: 24),
            ),
            IconButton(
              onPressed: () async {
                final TimeOfDay result = await showTimeRangePicker(context: context);
                print(result);
              },
              icon: const Icon(Icons.watch),
            ),
          ],
        ),
      ),
    );
  }
}
