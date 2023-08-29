import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataState<T> {
  final T? data;
  final FirebaseException? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({required T data}) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed({FirebaseException? firebaseError, Exception? error})
      : super();
}
