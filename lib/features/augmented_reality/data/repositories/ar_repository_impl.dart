import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/augmented_reality/data/data_sources/remote/ar_api_service.dart';
import 'package:dental_hero/features/augmented_reality/domain/entities/ar_document.dart';

import '../../domain/repository/ar_repository.dart';

class ArRepositoryImpl implements ArRepository {
  final ArApiService _arApiService;

  ArRepositoryImpl({required ArApiService arApiService})
      : _arApiService = arApiService;

  @override
  Future<DataState<ArDocumentEntity?>?> getArModel(String documentId) async {
    try {
      ArDocumentEntity? arDocumentEntity =
          await _arApiService.getActivity(documentId: documentId);

      if (arDocumentEntity == null) {
        return DataFailed(error: Exception("ArDocument not found"));
      }

      return DataSuccess(data: arDocumentEntity);
    } on Exception catch (e) {
      return DataFailed(error: e);
    }
  }
}
