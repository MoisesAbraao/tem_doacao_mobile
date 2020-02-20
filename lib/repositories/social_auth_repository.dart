import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/errors/failures.dart';

abstract class ISocialAuthRepository {
  /// try to sign in with google,
  /// when the user cancels the operation, the result will be `null`
  Future<Either<Failure, String>> googleSignIn();
  Future<Either<Failure, void>> googleSignOut();
}

class SocialAuthRepository implements ISocialAuthRepository {
  final GoogleSignIn _googleSignIn;

  SocialAuthRepository(this._googleSignIn);

  @override
  Future<Either<Failure, String>> googleSignIn() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      // canceled by the user
      if (googleSignInAccount == null)
        return Right(null);

      GoogleSignInAuthentication authentication = await googleSignInAccount.authentication;

      return Right(authentication.accessToken);
    } catch (error) {
      return Left(Failure.from(error));
    }
  }

  @override
  Future<Either<Failure, void>> googleSignOut() async {
    try {
      await _googleSignIn.signOut();

      return Right(null);
    } catch (error) {
      return Left(Failure.from(error));
    }
  }
}
