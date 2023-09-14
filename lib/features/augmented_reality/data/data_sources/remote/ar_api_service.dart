// firebase service
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/augmented_reality/data/models/ar_document.dart';

class ArApiService {
  final FirebaseFirestore _firestore;

  ArApiService({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future<ArDocumentModel?> getActivity({
    required String documentId,
  }) async {
    final data =
        await _firestore.collection('ar_documents').doc(documentId).get();

    if (!data.exists) {
      return null;
    }

    final arDocumentModel = ArDocumentModel.fromJson(data.data()!);

    return arDocumentModel;
  }
}
