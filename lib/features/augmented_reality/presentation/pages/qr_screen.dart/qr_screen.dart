import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../blocs/qr/qr_bloc.dart';
import '../../blocs/qr/qr_event.dart';
import '../../blocs/qr/qr_state.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final GlobalKey _gLobalkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: BlocListener<QrBloc, QrState>(
          listener: (context, state) {
            if (state is QrVerified) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/ar', (_) => false);
            }
          },
          child: _buildBody(context),
        ));
  }

  _buildAppBar() {
    return AppBar(
      title: const Text('Scan QR'),
    );
  }

  _buildBody(BuildContext context) {
    QrBloc qrBloc = BlocProvider.of<QrBloc>(context);

    return Center(
      child: Stack(
        children: <Widget>[
          QRView(
              key: _gLobalkey,
              onQRViewCreated: (QRViewController controller) {
                qrBloc.add(QrListenEvent(controller));
              }),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: BlocBuilder<QrBloc, QrState>(builder: (context, state) {
                if (qrBloc.state is QrVerified) {
                  return Text('${qrBloc.state.arDocumentEntity}');
                } else {
                  return const Text('Scan a code');
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
