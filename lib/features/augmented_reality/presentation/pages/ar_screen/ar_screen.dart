import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/ar/ar_bloc.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/qr/qr_bloc.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/qr/qr_event.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class ArScreen extends StatefulWidget {
  const ArScreen({Key? key}) : super(key: key);
  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  ARNode? node;
  ARAnchor? anchor;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppbar(height, width, context),
      body: BlocListener<ArBloc, ArState>(
          listener: (context, state) {
            if (state is ArSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message!)));
              BlocProvider.of<ArBloc>(context).add(ArResetEvent());
            } else if (state is ArFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message!)));
              BlocProvider.of<ArBloc>(context).add(ArResetEvent());
            }
          },
          child: Stack(children: [
            ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                child: SizedBox.expand(
                  child: DraggableScrollableSheet(
                      initialChildSize: 0.3,
                      minChildSize: 0.3,
                      maxChildSize: 0.5,
                      controller: DraggableScrollableController(),
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: purpleColor, width: 1.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Langkah Menyikat Gigi',
                                style: GoogleFonts.fredoka(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    color: purpleColor),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                BlocProvider.of<QrBloc>(context)
                                        .state
                                        .arDocumentEntity
                                        ?.description ??
                                    "-",
                                style: GoogleFonts.fredoka(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: purpleColor),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          ])),
    );
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "Images/triangle.png",
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    final qrBloc = BlocProvider.of<QrBloc>(context);
    final arBloc = BlocProvider.of<ArBloc>(context);

    // Check if there are any hit test results
    if (hitTestResults.isEmpty) {
      arBloc.add(const ArFailedEvent(message: "No hit test results."));
      return;
    }

    // Check if a node is already present
    if (node != null && anchor != null) {
      arObjectManager!.removeNode(node!);
      arAnchorManager!.removeAnchor(anchor!);
    }

    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);

    var newAnchor =
        ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);

    bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);

    if (didAddAnchor!) {
      anchor = newAnchor;

      // Add note to anchor
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri: qrBloc.state.arDocumentEntity?.modelUrl ??
              "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddNodeToAnchor =
          await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
      if (didAddNodeToAnchor!) {
        node = newNode;
      } else {
        arSessionManager!.onError("Adding Node to Anchor failed");
      }
    } else {
      arSessionManager!.onError("Adding Anchor failed");
    }
  }

  _buildAppbar(double height, double width, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height * 0.1),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffE9F3FF),
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff6A658A), width: 1.0),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.40),
                    offset: const Offset(4, -4),
                    blurRadius: 0,
                    spreadRadius: 0,
                    inset: true,
                  ),
                ],
              ),
              width: double.infinity,
              height: height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'assets/images/icon_back.png',
                          ),
                          iconSize: 36,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            BlocProvider.of<QrBloc>(context)
                                .add(const QrResetEvent());

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (route) => false);
                          },
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Kartu Digital",
                          style: GoogleFonts.fredoka(
                              color: purpleColor,
                              fontSize: 21,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.info),
                      color: shadeBlueColor,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Petunjuk Penggunaan"),
                                content: const Text(
                                    "1. Arahkan kamera ke permukaan datar\n2. Ketuk permukaan datar untuk menampilkan model 3D"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK"))
                                ],
                              );
                            });
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
