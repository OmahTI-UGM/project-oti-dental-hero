// firebase service
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/features/activity/data/models/activity.dart';

class ActivityApiService {
  final FirebaseFirestore _firestore;

  ActivityApiService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<ActivityModel?> saveActivity({
    required String userId,
    required DateTime date,
    required int duration,
    required int score,
    required TimeState timeState,
  }) async {
    final activity = await _firestore
        .collection('users')
        .doc(userId)
        .collection('activities')
        .add({
      'date': date,
      'duration': duration,
      'score': score,
      'timeState': timeState.value,
    });

    return ActivityModel(
      id: activity.id,
      date: date,
      duration: duration,
      score: score,
      timeState: timeState,
    );
  }

  Future<ActivityModel?> getActivity({
    required String userId,
    required DateTime date,
  }) async {
    final activity = await _firestore
        .collection('users')
        .doc(userId)
        .collection('activities')
        .where('date', isEqualTo: date)
        .get();

    if (activity.docs.isEmpty) {
      return null;
    }

    return ActivityModel.fromJson(activity.docs.first.data());
  }

  Future<List<ActivityModel>?> getActivities({
    required String userId,
  }) async {
    final activities = await _firestore
        .collection('users')
        .doc(userId)
        .collection('activities')
        .get();

    if (activities.docs.isEmpty) {
      return null;
    }

    return activities.docs
        .map((e) => ActivityModel.fromJson(
              Map<String, dynamic>.from(e.data())..addAll({'id': e.id}),
            ))
        .toList();
  }

  Future<void> updateActivity({
    required String userId,
    required DateTime date,
    required int duration,
    required int score,
    required TimeState timeState,
  }) async {
    final parsedDate = DateTime(date.year, date.month, date.day);

    final activity = await _firestore
        .collection('users')
        .doc(userId)
        .collection('activities')
        .where('date', isEqualTo: parsedDate)
        .where('timeState', isEqualTo: timeState.value)
        .get();

    if (activity.docs.isEmpty) {
      throw Exception('Activity not found');
    }

    await activity.docs.first.reference.update({
      'duration': duration,
      'score': score,
    });
  }

  Future<void> createInitialActivities({
    required String userId,
    int days = 30,
  }) async {
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);

    final activitiesDay = List.generate(
      days,
      (index) => ActivityModel(
        date: currentDate.add(Duration(days: index)),
        timeState: TimeState.day,
      ),
    );

    final activitiesNight = List.generate(
      days,
      (index) => ActivityModel(
        date: currentDate.add(Duration(days: index)),
        timeState: TimeState.night,
      ),
    );

    var batch = _firestore.batch();

    for (var doc in activitiesDay) {
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('activities')
          .doc();

      batch.set(docRef, doc.toMap());
    }

    for (var doc in activitiesNight) {
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('activities')
          .doc();

      batch.set(docRef, doc.toMap());
    }

    batch.commit();
  }
}
