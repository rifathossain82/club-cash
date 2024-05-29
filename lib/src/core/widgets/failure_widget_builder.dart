import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FailureWidgetBuilder extends StatelessWidget {
  final String? svgIconPath;
  final String? title;

  const FailureWidgetBuilder({
    Key? key,
    this.svgIconPath,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgIconPath ?? AssetPath.noDataFoundIcon,
              height: context.screenHeight * 0.27,
              width: context.screenWidth,
              alignment: Alignment.center,
            ),
            Text(
              title ?? 'No Data Found!',
              style: context.appTextTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
