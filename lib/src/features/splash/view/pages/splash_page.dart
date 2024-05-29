import 'dart:async';
import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/services/local_storage.dart';
import 'package:club_cash/src/core/theme/app_theme.dart';
import 'package:club_cash/src/core/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  setSplashDuration() async {
    return Timer(
      const Duration(seconds: 3),
      () => pageNavigation(),
    );
  }

  void pageNavigation() async {
    var token = LocalStorage.getData(key: LocalStorageKey.token);

    if(token != null){
      Get.offAllNamed(RouteGenerator.login);
    } else{
      Get.offAllNamed(RouteGenerator.login);
    }
  }

  @override
  void initState() {
    super.initState();

    /// To hide status bar.
    AppTheme.hideStatusBar();

    /// To set duration and control what next after splash duration
    setSplashDuration();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );

    animation.addListener(() => setState(() {}));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    AppTheme.enableInitialThemeSetting();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetPath.appLogo,
          height: animation.value * 200,
          width: animation.value * 200,
        ),
      ),
    );
  }
}
