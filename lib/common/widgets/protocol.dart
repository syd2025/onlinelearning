import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class ProtocolTipText extends StatelessWidget {
  final String startText;
  final TextStyle? normalStyle;
  final TextStyle? linkStyle;

  const ProtocolTipText(
      {super.key, required this.startText, this.normalStyle, this.linkStyle});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: RichText(
              text: TextSpan(children: _buildTextSpans(context)),
              maxLines: 5,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildTextSpans(BuildContext context) {
    final background = Theme.of(context).scaffoldBackgroundColor;
    final bg = background.toHex();
    final fg = Theme.of(context).textTheme.titleMedium?.color?.toHex() ??
        background.inverse.toHex();
    final tapGesture1 = TapGestureRecognizer()
      ..onTap = () {
        Get.to(
          () => WebViewPage(
            title: LocaleKeys.userProtocol.tr,
            page: 'userprotocol',
            backgroundColor: bg,
            foregroundColor: fg,
          ),
        );
      };
    final tapGesture2 = TapGestureRecognizer()
      ..onTap = () {
        Get.to(
          () => WebViewPage(
            title: LocaleKeys.userProtocol.tr,
            page: 'userprivacy',
            backgroundColor: bg,
            foregroundColor: fg,
          ),
        );
      };
    return [
      TextSpan(text: startText, style: normalStyle),
      TextSpan(
          text: LocaleKeys.loginFooterText2.tr,
          style: linkStyle,
          recognizer: tapGesture1),
      TextSpan(text: LocaleKeys.loginFooterText3.tr, style: normalStyle),
      TextSpan(
          text: LocaleKeys.loginFooterText4.tr,
          style: linkStyle,
          recognizer: tapGesture2),
    ];
  }
}
