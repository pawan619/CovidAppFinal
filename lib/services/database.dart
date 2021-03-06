import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidCare/model/empDetail.dart';
import 'package:covidCare/model/stuDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:covidCare/model/emp.dart';
import 'package:covidCare/model/stu.dart';

abstract class Database {
  Future<void> createEmp(Emp emp);
  Stream<List<Emp>> empStream();
  Stream<List<Stu>> stuStream();
  Stream<List<EmpDetail>> empDetailStream({Emp emp});
  Stream<List<StuDetail>> stuDetailStream({Stu stu});
  Stream<List<Emp>> empStreamSearch(String cat, String catVal);
  Stream<List<Stu>> stuStreamSearch(String cat, String catVal);
  Stream<List<Stu>> stuMultiSearch(String dval, String mval);
  Stream<List<Emp>> empMultiSearch(String dval, String mval);
}

class FirestoreDatabase implements Database {
  Stream<List<Emp>> empStream() {
    final path = 'Employee';
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => Emp(
            id: snapshot.data['emp_id'],
            name: snapshot.data['emp_name'],
            temp: snapshot.data['emp_temp'],
            depart: snapshot.data['emp_depart'],
            mask: snapshot.data['emp_mask'],
            img: snapshot.data['emp_img'],
            email: snapshot.data['emp_email'],
            phone: snapshot.data['emp_phone'],
          ),
        )
        .toList());
  }

  Stream<List<Emp>> empStreamSearch(String cat, String catVal) {
    final path = 'Employee';
    final reference =
        Firestore.instance.collection(path).where('$cat', isEqualTo: '$catVal');

    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => Emp(
            id: snapshot.data['emp_id'],
            name: snapshot.data['emp_name'],
            temp: snapshot.data['emp_temp'],
            depart: snapshot.data['emp_depart'],
            mask: snapshot.data['emp_mask'],
            img: snapshot.data['emp_img'],
            email: snapshot.data['emp_email'],
            phone: snapshot.data['emp_phone'],
          ),
        )
        .toList());
  }

  Stream<List<EmpDetail>> empDetailStream({Emp emp}) {
    final path = 'Employee/${emp.id}/Detail';
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => EmpDetail(
            temp: snapshot.data['emp_temp'],
            mask: snapshot.data['emp_mask'],
            date: snapshot.data['emp_date'],
          ),
        )
        .toList());
  }

  Stream<List<StuDetail>> stuDetailStream({Stu stu}) {
    final path = 'Student/${stu.id}/Details';
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => StuDetail(
            temp: snapshot.data['s_temp'],
            mask: snapshot.data['s_mask'],
            date: snapshot.data['s_date'],
          ),
        )
        .toList());
  }

  Stream<List<Stu>> stuStream() {
    final path = 'Student';
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => Stu(
            id: snapshot.data['s_id'],
            name: snapshot.data['s_name'],
            temp: snapshot.data['s_temp'],
            depart: snapshot.data['s_depart'],
            mask: snapshot.data['s_mask'],
            email: snapshot.data['s_email'],
            phone: snapshot.data['s_phone'],
            img: snapshot.data['s_img'],
          ),
        )
        .toList());
  }

  Stream<List<Stu>> stuStreamSearch(String cat, String catVal) {
    final path = 'Student';
    final reference =
        Firestore.instance.collection(path).where('$cat', isEqualTo: '$catVal');
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => Stu(
            id: snapshot.data['s_id'],
            name: snapshot.data['s_name'],
            temp: snapshot.data['s_temp'],
            depart: snapshot.data['s_depart'],
            mask: snapshot.data['s_mask'],
            email: snapshot.data['s_email'],
            phone: snapshot.data['s_phone'],
            img: snapshot.data['s_img'],
          ),
        )
        .toList());
  }

  Stream<List<Stu>> stuMultiSearch(String dval, String mval) {
    final path = 'Student';
    final reference = Firestore.instance
        .collection(path)
        .where('s_depart', isEqualTo: '$dval')
        .where('s_mask', isEqualTo: '$mval');
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => Stu(
            id: snapshot.data['s_id'],
            name: snapshot.data['s_name'],
            temp: snapshot.data['s_temp'],
            depart: snapshot.data['s_depart'],
            mask: snapshot.data['s_mask'],
            email: snapshot.data['s_email'],
            phone: snapshot.data['s_phone'],
            img: snapshot.data['s_img'],
          ),
        )
        .toList());
  }

  Stream<List<Emp>> empMultiSearch(String dval, String mval) {
    final path = 'Employee';
    final reference = Firestore.instance
        .collection(path)
        .where('emp_depart', isEqualTo: '$dval')
        .where('emp_mask', isEqualTo: '$mval');

    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => Emp(
            id: snapshot.data['emp_id'],
            name: snapshot.data['emp_name'],
            temp: snapshot.data['emp_temp'],
            depart: snapshot.data['emp_depart'],
            mask: snapshot.data['emp_mask'],
            img: snapshot.data['emp_img'],
            email: snapshot.data['emp_email'],
            phone: snapshot.data['emp_phone'],
          ),
        )
        .toList());
  }

  Future<void> createEmp(Emp emp) async {
    final path = 'Employee/emp_abc';
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(emp.toMap());
  }
}
