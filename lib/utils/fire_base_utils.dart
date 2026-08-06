import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/events.dart';
import 'package:evently/models/user.dart';

class FireBaseUtils {
  static String eventCollectionKey = 'Events';
  static String userEventsCollectionKey = 'User Events';

  static CollectionReference<Event> getFireBaseEventsCollection() {
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
      var eventRef = getFireBaseEventsCollection().doc();
      event.id = eventRef.id;
      await eventRef.set(event);
      print("Event Added Successfully");
    } catch (e) {
      print("Firebase Error: $e");
    }
  }

  static CollectionReference<MyUsers> getFireBaseUsersCollection() {
    return FirebaseFirestore.instance.collection(MyUsers.myUsersCollectionKey)
        .withConverter<MyUsers>(
      fromFirestore: (snapshot, options) {
        return MyUsers.fromFireBase(snapshot.data()!);
      },
      toFirestore: (user, options) {
        return user.toFireStore();
      },);
  }

  static Future<void> setUser(MyUsers user) async {
    await getFireBaseUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUsers> getUser({required String userId}) async {
    var doc = await getFireBaseUsersCollection().doc(userId).get();
    return doc.data()!;
  }

  static CollectionReference<Event> getFireBaseUsersEventsCollection(
      String userId) {
    return getFireBaseUsersCollection().doc(userId).collection(
        userEventsCollectionKey).
    withConverter<Event>(
      fromFirestore: (snapshot, options) {
        return Event.fromFireStore(snapshot.data()!);
      },
      toFirestore: (event, options) => event.toFireStore(),);
  }

  static Future<void> setUserEvent(String userId, Event event) async {
    var doc = await getFireBaseUsersEventsCollection(userId).doc();
    event.id = doc.id;
    doc.set(event);
  }
}
