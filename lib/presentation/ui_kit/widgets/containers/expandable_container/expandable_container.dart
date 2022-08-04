import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.collapsed,
            if (isExpanded) widget.expanded,
          ],
        ),
      ),
    );
  }
}
