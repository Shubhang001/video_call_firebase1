import 'package:flutter/material.dart';
import 'package:video_call_firebase1/vc.dart';
import 'package:video_call_firebase1/videocall.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userid = TextEditingController();

  @override
  void initState() {
    onUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 300,
            ),
            const Text("Enter User ID"),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              width: 300,
              child: TextField(
                controller: userid,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ZegoSendCallInvitationButton(
              onPressed: (code, message, p2) => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => Vc(
                          navigatorKey: widget.navigatorKey,
                          localUsername: userid.text.toString(),
                          localUserId: userid.text.toString(),
                          roomId: "12345"))),
              iconSize: Size.fromRadius(20),
              callID: "12345",
              isVideoCall: true,
              resourceID: "zegouikit_call", // For offline call notification
              invitees: [
                ZegoUIKitUser(
                  id: userid.text.toString(),
                  name: userid.text.toString(),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => VideoCall(
                          navigatorKey: widget.navigatorKey,
                          localUsername: userid.text.toString(),
                          localUserId: userid.text.toString(),
                          roomId: "12345")),
                );
              },
              child: Container(
                height: 30,
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: const Center(
                    child: Text(
                  "Join",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final callInvitationController = ZegoUIKitPrebuiltCallController();

  void onUserLogin() {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
        events: ZegoUIKitPrebuiltCallInvitationEvents(),
        androidNotificationConfig: ZegoAndroidNotificationConfig(
            channelID: "Suharsh", channelName: "Suharsh"),
        appID: 1219133755 /*input your AppID*/,
        appSign:
            "4d20c8e94ac1dcc5b470d261999892b44157315ec4de62ea8648a90319f11414" /*input your AppSign*/,
        userID: "Suharsh",
        userName: "Suharsh",
        plugins: [ZegoUIKitSignalingPlugin()],
        controller: callInvitationController,
        requireConfig: (ZegoCallInvitationData data) {
          var config = (data.invitees.length > 1)
              ? ZegoCallType.videoCall == data.type
                  ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                  : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
              : ZegoCallType.videoCall == data.type
                  ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                  : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

          // Modify your custom configurations here.
          config.durationConfig.isVisible = true;
          config.durationConfig.onDurationUpdate = (Duration duration) {
            if (duration.inSeconds >= 5 * 60) {
              callInvitationController
                  .hangUp(widget.navigatorKey.currentState!.context);
            }
          };

          return config;
        });
  }

  /// on App's user logout
  void onUserLogout() {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}
