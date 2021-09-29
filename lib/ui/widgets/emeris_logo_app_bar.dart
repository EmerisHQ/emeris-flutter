import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class EmerisLogoAppBar extends StatelessWidget with PreferredSizeWidget {
  const EmerisLogoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.album_outlined), // TODO replace with proper emeris logo
          const SizedBox(width: CosmosAppTheme.spacingM),
          Text(strings.appTitle),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
