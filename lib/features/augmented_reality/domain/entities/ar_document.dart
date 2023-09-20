import 'package:equatable/equatable.dart';

class ArDocumentEntity extends Equatable {
  final String? description;
  final String? modelUrl;

  const ArDocumentEntity({
    this.description,
    this.modelUrl,
  });

  @override
  List<Object?> get props => [
        description,
        modelUrl,
      ];

  @override
  String toString() {
    return 'ArDocumentEntity{description: $description, modelUrl: $modelUrl}';
  }
}
