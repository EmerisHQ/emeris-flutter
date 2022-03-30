import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/asset.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/widgets/balance_selector_item_view.dart';
import 'package:flutter_app/utils/strings.dart';

class BalanceSelectorList extends StatefulWidget {
  const BalanceSelectorList({
    required this.assets,
    required this.onTapChainAsset,
    Key? key,
  }) : super(key: key);

  final List<Asset> assets;

  // ignore: diagnostic_describe_all_properties
  final void Function(ChainAsset)? onTapChainAsset;

  @override
  State<BalanceSelectorList> createState() => _BalanceSelectorListState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Asset>('assets', assets));
  }
}

class _BalanceSelectorListState extends State<BalanceSelectorList> {
  late List<BalanceSelectorItem> _items;
  late List<BalanceSelectorItem> _parents;

  String get _message {
    return _parents.isNotEmpty
        ? strings.selectAssetMessageFormat(
            _parents.last.title,
            _items.length,
          )
        : '';
  }

  @override
  void initState() {
    super.initState();
    _parents = [];
    _items = widget.assets.map(BalanceSelectorItem.asset).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: CosmosTheme.of(context).spacingM,
        ),
        SizedBox(
          height: 40,
          child: Stack(
            children: [
              Offstage(
                offstage: _parents.isEmpty,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CosmosBackButton(
                    onTap: _onTapBack,
                  ),
                ),
              ),
              Center(
                child: Text(
                  _parents.isEmpty ? strings.selectAssetTitle : strings.selectChainTitle,
                  style: CosmosTextTheme.title1Medium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 70,
          child: Center(
            child: AnimatedOpacity(
              duration: const LongDuration(),
              curve: Curves.easeInOutQuint,
              opacity: _message.isEmpty ? 0.0 : 1.0,
              child: Text(
                _message,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const ShortDuration(),
          child: ListView.builder(
            key: ValueKey(_parents.length),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: theme.spacingS,
                  horizontal: theme.spacingL,
                ),
                child: BalanceSelectorItemView(
                  item: _items[index],
                  onTap: () => _onTapItem(_items[index]),
                ),
              );
            },
            itemCount: _items.length,
          ),
        ),
      ],
    );
  }

  void _onTapItem(BalanceSelectorItem item) {
    final asset = item.chainAsset;
    if (asset != null) {
      widget.onTapChainAsset?.call(asset);
    } else if (item.subItems.isNotEmpty) {
      setState(() {
        _parents.add(item);
        _items = item.subItems;
      });
    }
  }

  void _onTapBack() {
    if (_parents.isNotEmpty) {
      setState(() {
        _parents.removeLast();
        _items = _parents.isEmpty ? widget.assets.map(BalanceSelectorItem.asset).toList() : _parents.last.subItems;
      });
    }
  }
}
