import 'package:flutter/material.dart'
    show AlertDialog, IconButton, Icons, InputDecoration, TextButton, TextField, UnderlineInputBorder;
import 'package:flutter/widgets.dart';
import '../../../../../../../domain/models/models.dart';
import '../../../../../../static_methods/static_methods.dart';
import '../../../../../../ui_kit/ui_kit.dart';

class MetroMultiselect extends StatefulWidget {
  const MetroMultiselect({
    required this.allMetroStations,
    required this.selectedMetroStations,
    required this.onConfirmSelect,
    this.searchable = true,
    this.title,
    super.key,
  });

  final List<MetroStationModel> allMetroStations;
  final List<MetroStationModel> selectedMetroStations;
  final Function(List<MetroStationModel>) onConfirmSelect;
  final bool? searchable;
  final String? title;

  @override
  State<MetroMultiselect> createState() => _MetroMultiselectState();
}

class _MetroMultiselectState extends State<MetroMultiselect> {
  bool _showSearch = false;
  final List<MetroStationModel> selectedMetroStations = [];
  final List<MetroStationModel> searchedMetroStations = [];

  Widget _buildChipItem(MetroStationModel station) {
    return TouchableOpacity(
      onPressed: () async {
        if (!selectedMetroStations.contains(station)) {
          setState(() => selectedMetroStations.add(station));
        } else {
          setState(() => selectedMetroStations.remove(station));
        }
      },
      child: CategoryChip(
        backgroundColor: selectedMetroStations.contains(station)
            ? StaticMethods.getColorByMetroLine(station.line)
            : StaticMethods.getColorByMetroLine(station.line).withOpacity(0.5),
        textColor: AppColors.textOnColors,
        childText: station.title,
      ),
    );
  }

  @override
  void initState() {
    if (widget.selectedMetroStations.isNotEmpty) {
      for (final station in widget.selectedMetroStations) {
        selectedMetroStations.add(station);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (searchedMetroStations.isEmpty) {
      for (final station in widget.allMetroStations) {
        searchedMetroStations.add(station);
      }
    }

    return AlertDialog(
      backgroundColor: AppColors.backgroundCard,
      title: widget.searchable == false
          ? Text(widget.title ?? "Выбрать")
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _showSearch
                    ? Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Поиск",
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                            ),
                            onChanged: (query) {
                              searchedMetroStations.clear();
                              for (final station in widget.allMetroStations) {
                                if (station.title.contains(query)) {
                                  searchedMetroStations.add(station);
                                }
                              }
                              for (final station in searchedMetroStations) {
                                if (!station.title.contains(query)) {
                                  searchedMetroStations.remove(station);
                                }
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      )
                    : Text(widget.title ?? "Выбрать"),
                IconButton(
                  icon: _showSearch ? const Icon(Icons.close) : const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _showSearch = !_showSearch;
                    });
                  },
                ),
              ],
            ),
      contentPadding: const EdgeInsets.all(20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.73,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: searchedMetroStations.map(_buildChipItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Отмена", style: TextStyle(color: AppColors.text)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Oк', style: TextStyle(color: AppColors.text)),
          onPressed: () {
            widget.onConfirmSelect(selectedMetroStations);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
