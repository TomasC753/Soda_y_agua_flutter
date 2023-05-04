import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum LogoType {
  normal,
  normalOneColor,
  shield,
  shieldOnecolor,
  compact,
  compactOneColor,
}

Map<LogoType, String> directories = {
  LogoType.normal: 'assets/Logos/Nec_coffee_color_v2.svg',
  LogoType.normalOneColor: 'assets/Logos/Nec_coffee_only_black_v2.svg',
  LogoType.compact: 'assets/Logos/Nec_coffee_color_compact.svg',
  LogoType.compactOneColor: 'assets/Logos/Nec_coffee_only_black_compact.svg',
  LogoType.shield: 'assets/Logos/Nec_coffee_shield_color.svg',
  LogoType.shieldOnecolor: 'assets/Logos/Nec_coffee_shield_one_color.svg',
};

class Logo extends StatelessWidget {
  double? width;
  double? height;
  Color color;
  LogoType type;

  Logo(
      {Key? key,
      this.color = Colors.black,
      this.type = LogoType.normal,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type != LogoType.compactOneColor &&
        type != LogoType.shieldOnecolor &&
        type != LogoType.normalOneColor) {
      return SvgPicture.asset(
        directories[type] ?? directories[LogoType.normal]!,
        width: width,
        height: height,
      );
    }
    return SvgPicture.asset(
      directories[type] ?? directories[LogoType.normal]!,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
