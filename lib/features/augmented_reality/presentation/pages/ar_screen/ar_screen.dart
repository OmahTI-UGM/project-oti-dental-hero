import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/qr/qr_bloc.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/qr/qr_event.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math';

class ArScreen extends StatefulWidget {
  const ArScreen({Key? key}) : super(key: key);
  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? webObjectNode;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Local & Web Objects'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<QrBloc>(context).add(const QrResetEvent());

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            },
          ),
        ),
        body: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: onWebObjectAtOriginButtonPressed,
                        child: const Text("Add/Remove Web\nObject at Origin")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: onWebObjectShuffleButtonPressed,
                        child: const Text("Shuffle Web\nObject at Origin")),
                  ],
                )
              ]))
        ]));
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "Images/triangle.png",
          showWorldOrigin: true,
          handleTaps: false,
        );
    this.arObjectManager!.onInitialize();
  }

  Future<void> onWebObjectAtOriginButtonPressed() async {
    final qrBloc = BlocProvider.of<QrBloc>(context);

    if (webObjectNode != null) {
      arObjectManager!.removeNode(webObjectNode!);
      webObjectNode = null;
    } else {
      String uri = qrBloc.state.arDocumentEntity?.modelUrl ??
          "https://firebasestorage.googleapis.com/v0/b/dental-hero-7ccbc.appspot.com/o/models%2FAAAAA.glb?alt=media&token=537e0209-3912-44e6-a752-4ca2299708cd";
      var newNode = ARNode(
        type: NodeType.webGLB,
        uri: uri,
        scale: Vector3(0.2, 0.2, 0.2),
      );
      bool? didAddWebNode = await arObjectManager!.addNode(newNode);
      webObjectNode = (didAddWebNode!) ? newNode : null;
    }
  }

  Future<void> onWebObjectShuffleButtonPressed() async {
    if (webObjectNode != null) {
      var newScale = Random().nextDouble() / 3;
      var newTranslationAxis = Random().nextInt(3);
      var newTranslationAmount = Random().nextDouble() / 3;
      var newTranslation = Vector3(0, 0, 0);
      newTranslation[newTranslationAxis] = newTranslationAmount;
      var newRotationAxisIndex = Random().nextInt(3);
      var newRotationAmount = Random().nextDouble();
      var newRotationAxis = Vector3(0, 0, 0);
      newRotationAxis[newRotationAxisIndex] = 1.0;

      final newTransform = Matrix4.identity();

      newTransform.setTranslation(newTranslation);
      newTransform.rotate(newRotationAxis, newRotationAmount);
      newTransform.scale(newScale);

      webObjectNode!.transform = newTransform;
    }
  }
}
