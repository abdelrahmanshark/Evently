import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/events.dart';

class FireBaseUtils {
  static String eventCollectionKey = 'Events';

  static CollectionReference<Event> getFireBaseCollection() {
    return FirebaseFirestore.instance
        .collection(eventCollectionKey)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<void> setEvent(Event event) async {
    try {
      var eventRef = getFireBaseCollection().doc();
      event.id = eventRef.id;
      await eventRef.set(event);
      print("Event Added Successfully");
    } catch (e) {
      print("Firebase Error: $e");
    }
  }
}
