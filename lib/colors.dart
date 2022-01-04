import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

const kBackgroundColor = Color(0xffFFFFFF);
const kHomePageContainerColor = Color(0xffFFE082);
const kBoxShadowColor = Color(0x00000029);
const kContainerBorderColor = Color(0xff444444);

class HexColor extends Color {
  static const MethodChannel _channel = MethodChannel('hexcolor');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
