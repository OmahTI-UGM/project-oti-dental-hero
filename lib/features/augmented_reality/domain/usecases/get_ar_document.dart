import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:dental_hero/features/augmented_reality/domain/entities/ar_document.dart';
import 'package:equatable/equatable.dart';

import '../repository/ar_repository.dart';

class GetArDocumentUseCase
    implements UseCase<DataState<ArDocumentEntity?>?, GetArDocumentParams> {
  final ArRepository repository;

  const GetArDocumentUseCase({required this.repository});

  @override
  Future<DataState<ArDocumentEntity?>?> call(
      {GetArDocumentParams? params}) async {
    return await repository.getArModel(
      params!.documentId,
    );
  }
}

class GetArDocumentParams extends Equatable {
  final String documentId;

  const GetArDocumentParams({
    required this.documentId,
  });

  @override
  List<Object?> get props => [
        documentId,
      ];
}
