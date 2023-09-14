import 'package:qr_code_scanner/qr_code_scanner.dart';

abstract class QrEvent {
  const QrEvent();
}

class QrListenEvent extends QrEvent {
  final QRViewController controller;
  const QrListenEvent(this.controller);
}

class QrStopEvent extends QrEvent {
  const QrStopEvent();
}

class QrSuccessEvent extends QrEvent {
  final Barcode barcode;
  const QrSuccessEvent({
    required this.barcode,
  });
}

class QrVerifyEvent extends QrEvent {
  const QrVerifyEvent();
}

class QrFailedEvent extends QrEvent {
  final Exception error;
  const QrFailedEvent({
    required this.error,
  });
}

class QrResetEvent extends QrEvent {
  const QrResetEvent();
}
