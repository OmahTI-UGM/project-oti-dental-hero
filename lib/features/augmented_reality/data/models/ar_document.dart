import 'package:dental_hero/features/augmented_reality/domain/entities/ar_document.dart';

class ArDocumentModel extends ArDocumentEntity {
  const ArDocumentModel(
      {required String? description, required String? modelUrl})
      : super(
          description: description,
          modelUrl: modelUrl,
        );

  factory ArDocumentModel.fromJson(Map<String, dynamic> map) {
    return ArDocumentModel(
      description: map['description'],
      modelUrl: map['modelUrl'],
    );
  }

  factory ArDocumentModel.fromEntity(ArDocumentEntity entity) {
    return ArDocumentModel(
      description: entity.description,
      modelUrl: entity.modelUrl,
    );
  }

  @override
  List<Object?> get props => [
        description,
        modelUrl,
      ];

  @override
  String toString() {
    return 'ArDocumentModel{description: $description, modelUrl: $modelUrl}';
  }
}
