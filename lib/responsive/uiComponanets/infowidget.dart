import 'package:flutter/cupertino.dart';
import '../functions/getDwviceInfo.dart';
import '../models/deviceInfo.dart';
class Infowidget extends StatelessWidget {
  final Widget Function (BuildContext context,Deviceinfo deviceinfo) builder;
  const Infowidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var mediaQueryData = MediaQuery.of(context);
      var deviceInfo = Deviceinfo(
        orientation: mediaQueryData.orientation,
        deviceType: getDeviceType(mediaQueryData),
        screenHeight: mediaQueryData.size.height,
        screenWidth: mediaQueryData.size.width,
        localHeight: constraints.maxHeight,
        localWidth: constraints.maxWidth,
      );
      return builder(context,deviceInfo);
    });
  }
}