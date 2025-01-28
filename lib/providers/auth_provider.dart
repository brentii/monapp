import 'package:firebase_auth/firebase_auth.dart';
import 'package:monapp/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {
  // Create a stream of auth state changes
  final Stream<User?> firebaseUserStream = FirebaseAuth.instance.authStateChanges();

  await for (final firebaseUser in firebaseUserStream) {
    if (firebaseUser != null) {
      try {
        // Check if the account is valid by forcing a token refresh
        await firebaseUser.getIdToken(true);

        // If the account is valid, map it to AppUser
        yield AppUser(
          uid: firebaseUser.uid,
          email: firebaseUser.email!,
        );
      } catch (e) {
        // If there's an error (e.g., account disabled), sign out the user
        await FirebaseAuth.instance.signOut();
        yield null;
      }
    } else {
      // If the user is not signed in, emit null
      yield null;
    }
  }
});

/*
final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {

  //create a stream that provides continuous values (user/null)
  final Stream<AppUser?> userStream = FirebaseAuth.instance
    .authStateChanges().map((user) {
      if (user != null) {
        return AppUser(uid: user.uid, email: user.email!);
      }
      return null;
    }
  );

  //YIELD that value whenever it changes
  await for (final user in userStream) {
    yield user;
  }

});
*/