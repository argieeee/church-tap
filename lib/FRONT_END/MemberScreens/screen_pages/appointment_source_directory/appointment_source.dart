// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Appointment {
//   final String id;
//   //final String title;
//   final String description;
//   final DateTime date;
//   final String appointmenttype;
//
//   Appointment({
//     required this.id,
//    // required this.title,
//     required this.description,
//     required this.appointmenttype,
//     required this.date,
//     required String userID,
//   });
//
//   factory Appointment.fromFirestore(Map<String, dynamic> data, String id) {
//     return Appointment(
//       id: id,
//       //title: data['title'],
//       appointmenttype: data['appointmenttype'],
//       description: data['description'],
//       date: (data['date'] as Timestamp).toDate(), userID: '',
//     );
//   }
//
//
//
//   updateAppointment({required String appointmenttype, required String description, required DateTime date, required String userID}) {}
// }
//
//
//
//   // Add method to convert Event object to Firestore data
//   Future<void> updateAppointment({
//     //required String title,
//     required String appointmenttype,
//     required String description,
//     required DateTime date,
//     required String userID, // Pass userID
//   }) async {
//     try {
//       await FirebaseFirestore.instance.collection('appointments').doc(userID).update({
//        // 'title': title,
//         'appointmenttype': appointmenttype,
//         'description': description,
//         'date': Timestamp.fromDate(date),
//         'userID': userID, // Ensure userID is updated
//       });
//     } catch (e) {
//       print('Error updating event: $e');
//       rethrow;
//     }
//   }
//
