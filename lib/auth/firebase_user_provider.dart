import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ForTestingFirebaseUser {
  ForTestingFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

ForTestingFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ForTestingFirebaseUser> forTestingFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ForTestingFirebaseUser>(
            (user) => currentUser = ForTestingFirebaseUser(user));
