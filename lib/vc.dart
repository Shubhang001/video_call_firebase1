import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class Vc extends StatefulWidget {
  const Vc({
    super.key,
    required this.roomId,
    required this.localUserId,
    required this.localUsername,
  });
  final String roomId;
  final String localUserId;
  final String localUsername;

  @override
  State<Vc> createState() => _VcState();
}

class _VcState extends State<Vc> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          1219133755, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          "4d20c8e94ac1dcc5b470d261999892b44157315ec4de62ea8648a90319f11414", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: widget.localUserId,
      userName: widget.localUsername,
      callID: widget.roomId,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }
}
