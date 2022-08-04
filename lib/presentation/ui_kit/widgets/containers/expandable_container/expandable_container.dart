import 'package:flutter/widgets.dart';
import '../../../ui_kit.dart';

class ExpandableContainer extends StatefulWidget {
  const ExpandableContainer({
    required this.collapsed,
    required this.expanded,
    Key? key,
  }) : super(key: key);

  final Widget collapsed;
  final Widget expanded;

  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.collapsed,
          if (isExpanded) widget.expanded,
        ],
      ),
    );
  }
}
