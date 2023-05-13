import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import 'views.dart';

class BackgroundScreen extends StatelessWidget {
  final String appBarString;
  final Widget child;
  final double? elevation;

  const BackgroundScreen({
    Key? key,
    required this.appBarString,
    required this.child,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: OrientationBuilder(
      builder: (context, orientation) {
        return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.backgroundImage),
                    fit: BoxFit.fill)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar:
                  AppWidget.appBar(text: appBarString, elevation: elevation),
              body: child,
            ));
      },
    ));
  }
}
