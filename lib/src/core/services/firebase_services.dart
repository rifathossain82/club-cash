import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  late FirebaseFirestore _firestore;

  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  static Future<void> init() async {
    await Firebase.initializeApp();
    _instance._firestore = FirebaseFirestore.instance;
  }

  List<T> _handleQueryResponse<T>(
    QuerySnapshot<Map<String, dynamic>> response,
    T Function(Map<String, dynamic> data) fromJson,
  ) {
    try {
      return response.docs.map((doc) => fromJson(doc.data())).toList();
    } catch (e) {
      throw 'Error parsing Firestore response: $e';
    }
  }

  T? _handleDocumentResponse<T>(
    DocumentSnapshot<Map<String, dynamic>> doc,
    T Function(Map<String, dynamic>? data) fromJson,
  ) {
    try {
      return fromJson(doc.data());
    } catch (e) {
      throw 'Error parsing Firestore response: $e';
    }
  }

  void _handleError(dynamic error) {
    throw 'Firestore error: $error';
  }

  Future<void> addDocument({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collection).add(data);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<T?> getDocument<T>({
    required String collection,
    required String docId,
    required T Function(Map<String, dynamic>? data) fromJson,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection(collection).doc(docId).get();
      return _handleDocumentResponse(doc, fromJson);
    } catch (e) {
      _handleError(e);
    }
    return null;
  }

  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<List<T>> queryDocuments<T>({
    required String collection,
    required Map<String, dynamic> conditions,
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection(collection);
      conditions.forEach((field, value) {
        query = query.where(field, isEqualTo: value);
      });
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
      return _handleQueryResponse(querySnapshot, fromJson);
    } catch (e) {
      _handleError(e);
    }
    return [];
  }
}
