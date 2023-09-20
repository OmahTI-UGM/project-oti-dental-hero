import 'dart:convert';

import 'package:dental_hero/features/augmented_reality/domain/usecases/get_ar_document.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/qr/qr_event.dart';
import 'package:dental_hero/features/augmented_reality/presentation/blocs/qr/qr_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/ar_document.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  GetArDocumentUseCase getArDocumentUseCase;

  QrBloc({
    required this.getArDocumentUseCase,
  }) : super(const QrInitial()) {
    on<QrListenEvent>(onListen);
    on<QrStopEvent>(onStop);
    on<QrSuccessEvent>(onSuccess);
    on<QrFailedEvent>(onFailed);
    on<QrResetEvent>(onReset);
  }

  Future<void> onListen(QrListenEvent event, Emitter<QrState> emit) async {
    try {
      final controller = event.controller;

      controller.scannedDataStream.listen((event) {
        add(QrSuccessEvent(barcode: event));
      });

      emit(QrListening(controller: controller));
    } catch (e) {
      emit(QrFailed(error: Exception("Failed to listen to QR code.")));
    }
  }

  Future<void> onSuccess(QrSuccessEvent event, Emitter<QrState> emit) async {
    try {
      emit(QrSuccess(barcode: event.barcode));

      if (event.barcode.code is! String) {
        emit(QrFailed(error: Exception("Invalid QR data.")));
        return;
      }

      // parse json from barcode
      final json = jsonDecode(event.barcode.code as String);

      if (json is! Map<String, dynamic>) {
        emit(QrFailed(error: Exception("Invalid QR data.")));
        return;
      }

      // check if documentId is present
      if (!json.containsKey("documentId")) {
        emit(QrFailed(error: Exception("Invalid QR data. (Invalid JSON)")));
        return;
      }

      // check if documentId is a string
      if (json["documentId"] is! String) {
        emit(QrFailed(error: Exception("Invalid QR data. (Invalid JSON)")));
        return;
      }

      // get documentId
      final documentId = json["documentId"] as String;

      // get document
      final documentParams = GetArDocumentParams(documentId: documentId);
      final dataState = await getArDocumentUseCase(params: documentParams);

      if (dataState?.data is! ArDocumentEntity) {
        emit(QrFailed(error: Exception("Invalid QR data. (Invalid JSON)")));
        return;
      }

      emit(QrVerified(arDocumentEntity: dataState!.data));
    } catch (e) {
      emit(QrFailed(error: Exception("Failed to get QR code.")));
    }
  }

  Future<void> onFailed(QrFailedEvent event, Emitter<QrState> emit) async {
    try {
      emit(QrFailed(error: event.error));
    } catch (e) {
      emit(QrFailed(error: Exception("Failed to get QR code.")));
    }
  }

  Future<void> onReset(QrResetEvent event, Emitter<QrState> emit) async {
    try {
      emit(const QrInitial());
    } catch (e) {
      emit(QrFailed(error: Exception("Failed to reset QR code.")));
    }
  }

  Future<void> onStop(QrStopEvent event, Emitter<QrState> emit) async {
    try {
      final controller = state.controller;
      controller?.pauseCamera();
      emit(const QrInitial());
    } catch (e) {
      emit(QrFailed(error: Exception("Failed to stop QR code.")));
    }
  }
}
