import 'package:flutter/material.dart';
import 'expanded_section.dart';

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

class _ExpandableContainerState extends State<ExpandableContainer> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.collapsed,
            // if (_isExpanded)
            ExpandedSection(expand: _isExpanded, child: widget.expanded),
          ],
        ),
      ),
    );
  }
}
