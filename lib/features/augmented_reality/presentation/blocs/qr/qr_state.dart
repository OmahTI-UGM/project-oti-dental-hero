import 'package:dental_hero/features/augmented_reality/domain/entities/ar_document.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

abstract class QrState extends Equatable {
  final QRViewController? controller;
  final Barcode? barcode;
  final ArDocumentEntity? arDocumentEntity;

  const QrState({this.barcode, this.controller, this.arDocumentEntity});

  @override
  List<Object?> get props => [];
}

class QrInitial extends QrState {
  const QrInitial() : super(barcode: null);
}

class QrListening extends QrState {
  const QrListening({required QRViewController controller})
      : super(controller: controller);
}

class QrFailed extends QrState {
  final Exception? error;

  const QrFailed({this.error}) : super();

  String get message => error?.toString() ?? "QR Failed";
}

class QrSuccess extends QrState {
  const QrSuccess({Barcode? barcode}) : super(barcode: barcode);
}

class QrVerified extends QrState {
  const QrVerified({ArDocumentEntity? arDocumentEntity})
      : super(arDocumentEntity: arDocumentEntity);
}
