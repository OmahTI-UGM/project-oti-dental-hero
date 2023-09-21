// firebase service
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/core/constants/snapshot_state_enum.dart';
import 'package:dental_hero/features/gallery/data/models/comparison_snapshot.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class GalleryApiService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  GalleryApiService(
      {required FirebaseFirestore firestore,
      required FirebaseStorage firebaseStorage})
      : _firestore = firestore,
        _firebaseStorage = firebaseStorage;

  Future<ComparisonSnapshotModel?> getComparisonSnapshot({
    required String userId,
  }) async {
    final data = await _firestore
        .collection('users')
        .doc(userId)
        .collection('comparison_snapshots')
        .get();

    if (data.docs.isEmpty) {
      return null;
    }

    final model = data.docs.first.data();

    return ComparisonSnapshotModel(
      afterImageUrls: model['afterImageUrls'],
      beforeImageUrls: model['beforeImageUrls'],
    );
  }

  Future<List<String>> uploadComparisonSnapshotImages({
    required String userId,
    required List<XFile> images,
  }) async {
    if (images.length != 4) {
      throw Exception('Invalid number of images');
    }

    final List<String> uploadedImageUrls = [];

    for (final image in images) {
      final ref = _firebaseStorage.ref().child('users/$userId/${image.name}');

      await ref.putFile(File(image.path));

      final url = await ref.getDownloadURL();

      uploadedImageUrls.add(url);
    }

    return uploadedImageUrls;
  }

  Future<void> updateComparisonSnapshotImages({
    required String userId,
    required List<String> imageUrls,
    required SnapshotState snapshotState,
  }) async {
    if (imageUrls.length != 4) {
      throw Exception('Invalid number of images');
    }

    final data = await _firestore
        .collection('users')
        .doc(userId)
        .collection('comparison_snapshots')
        .get();

    if (data.docs.isEmpty) {
      // create new document
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('comparison_snapshots')
          .add({
        'afterImageUrls': [],
        'beforeImageUrls': [],
      });
    }

    // update existing document
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('comparison_snapshots')
        .doc(data.docs.first.id)
        .update({
      snapshotState == SnapshotState.before
          ? 'beforeImageUrls'
          : 'afterImageUrls': imageUrls,
    });
  }

  Future<void> createInitialComparisonSnapshot({
    required String userId,
    int days = 30,
  }) async {
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);

    final ComparisonSnapshotModel comparisonSnapshotModel =
        ComparisonSnapshotModel(
      before: currentDate,
      after: currentDate.add(
        const Duration(days: 30),
      ), // 30 days after,
    );

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('comparison_snapshots')
        .add(comparisonSnapshotModel.toMap());
  }
}
