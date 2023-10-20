import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({super.key, required this.meetingid});
  final String meetingid;

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  @override
  void initState() {
    super.initState();

    /// 1.1.1 define a navigator key
    final navigatorKey = GlobalKey<NavigatorState>();

    /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

    ZegoUIKit().initLog().then((value) {
      ///  Call the `useSystemCallingUI` method
      ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
        [ZegoUIKitSignalingPlugin()],
      );
    });

    onUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          1219133755, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          "4d20c8e94ac1dcc5b470d261999892b44157315ec4de62ea8648a90319f11414", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: 'user_id',
      userName: 'user_name',
      callID: widget.meetingid,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }

  void onUserLogin() {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 1219133755 /*input your AppID*/,
      appSign:
          "4d20c8e94ac1dcc5b470d261999892b44157315ec4de62ea8648a90319f11414" /*input your AppSign*/,
      userID: 'Client1',
      userName: 'C123',
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  /// on App's user logout
  void onUserLogout() {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}
