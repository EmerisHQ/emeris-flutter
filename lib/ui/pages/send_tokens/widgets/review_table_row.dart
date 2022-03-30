import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/expanded_indicator.dart';

class ReviewTableRow extends StatefulWidget {
  const ReviewTableRow({
    required this.title,
    required this.valueChild,
    this.expandedChild,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget valueChild;
  final Widget? expandedChild;

  @override
  State<ReviewTableRow> createState() => _ReviewTableRowState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(StringProperty('title', title));
  }
}

class _ReviewTableRowState extends State<ReviewTableRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacingL,
        vertical: theme.spacingM,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: widget.expandedChild == null ? null : _onTapHeader,
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: CosmosTextTheme.title0Bold,
                ),
                const Spacer(),
                if (!_expanded) widget.valueChild,
                if (widget.expandedChild != null) ExpandedIndicator(expanded: _expanded),
              ],
            ),
          ),
          if (widget.expandedChild != null)
            ExpandableContainer(
              expanded: _expanded,
              child: Padding(
                padding: EdgeInsets.only(top: theme.spacingL),
                child: widget.expandedChild,
              ),
            ),
        ],
      ),
    );
  }

  void _onTapHeader() => setState(() => _expanded = !_expanded);
}
