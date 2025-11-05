import 'package:cloud_firestore/cloud_firestore.dart';
import 'university.dart';

class UniversitiesService {
  final _col = FirebaseFirestore.instance.collection('universidades');

  Stream<List<University>> streamAll() {
    return _col.orderBy('nombre').snapshots().map(
      (s) => s.docs.map((d) => University.fromMap(d.id, d.data())).toList(),
    );
  }

  Future<void> create(University u) async {
    await _col.add(u.toMap());
  }

  Future<void> update(String id, University u) async {
    await _col.doc(id).update(u.toMap());
  }

  Future<void> delete(String id) async {
    await _col.doc(id).delete();
  }
}
