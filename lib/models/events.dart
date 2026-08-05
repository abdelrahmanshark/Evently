import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? eventName;
  String? eventTitle;
  String? eventDescrption;
  DateTime? eventDate;
  String? eventTime;
  bool? isFavorite;
  Event({
    this.id = '',
    required this.eventTime,
    required this.eventDate,
    required this.eventTitle,
    required this.eventDescrption,
    this.isFavorite = false,
    required this.eventName
  });

  Event.fromFireStore(Map<String, dynamic> data){
    id = data['id'];
    eventName = data['eventName'];
    eventTitle = data['eventTitle'];
    eventDescrption = data['eventDescrption'];
    eventDate = (data['eventDate'] as Timestamp).toDate();
    eventTime = data['eventTime'];
    isFavorite = data['isFavorite'];
  }

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'eventName': eventName,
      'eventTitle': eventTitle,
      'eventDescrption': eventDescrption,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'isFavorite': isFavorite
    };
}
}