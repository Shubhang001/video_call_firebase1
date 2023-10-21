import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class VideoCall extends StatefulWidget {
  const VideoCall(
      {super.key,
      required this.roomId,
      required this.localUserId,
      required this.localUsername});
  final String roomId;
  final String localUserId;
  final String localUsername;

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
      userID: widget.localUserId,
      userName: widget.localUsername,
      callID: widget.roomId,
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
      userID: "Shubhang",
      userName: "Shubhang",
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

/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class CallPage extends StatefulWidget {
  const CallPage(
      {super.key,
      required this.localUsername,
      required this.localUserId,
      required this.roomId});
  final String localUsername;
  final String localUserId;
  final String roomId;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  Widget? localView;
  Widget? remoteView;

  @override
  void setState(VoidCallback fn) {
    createEngine();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Call Page")),
      body: Stack(
        children: [
          localView ?? Container(),
          Positioned(
            top: MediaQuery.of(context).size.height / 20,
            right: MediaQuery.of(context).size.width / 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: remoteView ?? Container(color: Colors.transparent),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 20,
            left: 0,
            right: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.red),
                    onPressed: () => Navigator.pop(context),
                    child: const Center(child: Icon(Icons.call_end, size: 32)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createEngine() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Get your AppID and AppSign from ZEGOCLOUD Console
    //[My Projects -> AppID] : https://console.zegocloud.com/project
    await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
      1219133755,
      ZegoScenario.Default,
      appSign: kIsWeb
          ? null
          : "4d20c8e94ac1dcc5b470d261999892b44157315ec4de62ea8648a90319f11414",
    ));
  }

  void startListenEvent() {
    // Callback for updates on the status of other users in the room.
    // Users can only receive callbacks when the isUserStatusNotify property of ZegoRoomConfig is set to `true` when logging in to the room (loginRoom).
    ZegoExpressEngine.onRoomUserUpdate =
        (roomID, updateType, List<ZegoUser> userList) {
      debugPrint(
          'onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}');
    };
    // Callback for updates on the status of the streams in the room.
    ZegoExpressEngine.onRoomStreamUpdate =
        (roomID, updateType, List<ZegoStream> streamList, extendedData) {
      debugPrint(
          'onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData');
      if (updateType == ZegoUpdateType.Add) {
        for (final stream in streamList) {
          startPlayStream(stream.streamID);
        }
      } else {
        for (final stream in streamList) {
          stopPlayStream(stream.streamID);
        }
      }
    };
    // Callback for updates on the current user's room connection status.
    ZegoExpressEngine.onRoomStateUpdate =
        (roomID, state, errorCode, extendedData) {
      debugPrint(
          'onRoomStateUpdate: roomID: $roomID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };

    // Callback for updates on the current user's stream publishing changes.
    ZegoExpressEngine.onPublisherStateUpdate =
        (streamID, state, errorCode, extendedData) {
      debugPrint(
          'onPublisherStateUpdate: streamID: $streamID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };
  }

  void stopListenEvent() {
    ZegoExpressEngine.onRoomUserUpdate = null;
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onRoomStateUpdate = null;
    ZegoExpressEngine.onPublisherStateUpdate = null;
  }

  Future<ZegoRoomLoginResult> loginRoom() async {
    // The value of `userID` is generated locally and must be globally unique.
    final user = ZegoUser(widget.localUserId, widget.localUsername);

    // The value of `roomID` is generated locally and must be globally unique.
    final roomID = widget.roomId;

    // onRoomUserUpdate callback can be received when "isUserStatusNotify" parameter value is "true".
    ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()
      ..isUserStatusNotify = true;
    String serverSecret = "fa94dd0f974cf2e293728a526b028271";

    // log in to a room
    // Users must log in to the same room to call each other.
    return ZegoExpressEngine.instance
        .loginRoom(roomID, user, config: roomConfig)
        .then((ZegoRoomLoginResult loginRoomResult) {
      debugPrint(
          'loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
      if (loginRoomResult.errorCode == 0) {
        startPreview();
        startPublish();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('loginRoom failed: ${loginRoomResult.errorCode}')));
      }
      return loginRoomResult;
    });
  }

  Future<ZegoRoomLogoutResult> logoutRoom() async {
    stopPreview();
    stopPublish();
    return ZegoExpressEngine.instance.logoutRoom(widget.roomId);
  }

  late var localViewID;
  late var remoteViewID;
  Future<void> startPreview() async {
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      localViewID = viewID;
      ZegoCanvas previewCanvas =
          ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
    }).then((canvasViewWidget) {
      setState(() => localView = canvasViewWidget);
    });
  }

  Future<void> stopPreview() async {
    ZegoExpressEngine.instance.stopPreview();
    if (localViewID != null) {
      await ZegoExpressEngine.instance.destroyCanvasView(localViewID!);
      setState(() {
        localViewID = null;
        localView = null;
      });
    }
  }

  Future<void> startPublish() async {
    // After calling the `loginRoom` method, call this method to publish streams.
    // The StreamID must be unique in the room.
    String streamID = '${widget.roomId}_${widget.localUserId}_call';
    return ZegoExpressEngine.instance.startPublishingStream(streamID);
  }

  Future<void> stopPublish() async {
    return ZegoExpressEngine.instance.stopPublishingStream();
  }

  Future<void> startPlayStream(String streamID) async {
    // Start to play streams. Set the view for rendering the remote streams.
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      remoteViewID = viewID;
      ZegoCanvas canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
    }).then((canvasViewWidget) {
      setState(() => remoteView = canvasViewWidget);
    });
  }

  Future<void> stopPlayStream(String streamID) async {
    ZegoExpressEngine.instance.stopPlayingStream(streamID);
    if (remoteViewID != null) {
      ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
      setState(() {
        remoteViewID = null;
        remoteView = null;
      });
    }
  }
}*/
