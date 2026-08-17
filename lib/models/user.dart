class MyUsers {
  static String myUsersCollectionKey = "my users";
  String? id;
  String? name;
  String? email;

  MyUsers({required this.id, required this.name, required this.email});

  MyUsers.fromFireBase(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
  }

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
