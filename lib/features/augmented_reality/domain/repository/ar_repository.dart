import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/augmented_reality/domain/entities/ar_document.dart';

abstract class ArRepository {
  Future<DataState<ArDocumentEntity?>?> getArModel(String documentId);
}
