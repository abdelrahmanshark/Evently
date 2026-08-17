import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/events.dart';
import 'package:evently/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseUtils {
  static String eventCollectionKey = 'Events';
  static String userEventsCollectionKey = 'User Events';
  static String userFavoriteEventsCollectionKey = 'User Favorite Events';

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

  static Future<MyUsers?> getUser({required String userId}) async {
    var doc = await getFireBaseUsersCollection().doc(userId).get();
    return doc.data();
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

  static CollectionReference<Event> getFireBaseUsersFavoriteEventsCollection(
      String userId) {
    return getFireBaseUsersCollection().doc(userId).collection(
        userFavoriteEventsCollectionKey).
    withConverter<Event>(
      fromFirestore: (snapshot, options) {
        return Event.fromFireStore(snapshot.data()!);
      },
      toFirestore: (event, options) => event.toFireStore(),);
  }

  static Future<void> setUserFavoriteEvent(String userId, Event event) async {
    var doc = await getFireBaseUsersFavoriteEventsCollection(userId).doc();
    event.id = doc.id;
    doc.set(event);
  }



  static Future<void> setUserEvent(String userId, Event event) async {
    var doc = await getFireBaseUsersEventsCollection(userId).doc();
    event.id = doc.id;
    doc.set(event);
  }


  static Future<UserCredential> signInWithGoogle() async {
    // create google instance
    var google = GoogleSignIn.instance;
    //init Google Sign in Serves
    await google.initialize(
        serverClientId: "1063048862972-tsi1oacc1galrbuvsrbcbin3q6422tea.apps.googleusercontent.com");
    //go to authenticate to get the token id
    GoogleSignInAccount account = await google.authenticate();
    //get the tokenID
    var tokenId = account.authentication.idToken;
    // go to authorization to get the access token
    var clintAuth = await account.authorizationClient.authorizationForScopes(
        [ 'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile']);
    // get the access token
    var accessToken = clintAuth?.accessToken;
    //make the Credential
    var credential = GoogleAuthProvider.credential(
        accessToken: accessToken, idToken: tokenId);
    // sign in to fireBase with the Credential
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> removeEventFromFavorite(String userId,
      String eventId) async {
    await getFireBaseUsersFavoriteEventsCollection(userId)
        .doc(eventId)
        .delete();
  }

  static Future<void> addEventTOFavorite(String userId, Event event) async {
    await getFireBaseUsersFavoriteEventsCollection(userId).doc(event.id).set(
        event);
  }

}
