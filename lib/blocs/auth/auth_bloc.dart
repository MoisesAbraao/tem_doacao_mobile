import 'package:bloc/bloc.dart';
import 'package:tem_doacao_mobile/repositories/social_auth_repository.dart';

import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  final ISocialAuthRepository socialAuthRepository;

  AuthBloc(this.authRepository, this.socialAuthRepository);

  @override
  AuthState get initialState => Unauthenticated();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignInUp) {
      yield Authenticating();

      final googleAccessToken = await socialAuthRepository.googleSignIn();

      yield* googleAccessToken.fold(
        (failure) async* {
          yield AuthenticationFail(message: failure.message);
        },
        (googleAccessToken) async* {
          if (googleAccessToken == null) {
            yield Unauthenticated();
          } else {
            final tokenUser = await authRepository.signInUp(googleAccessToken);

            yield tokenUser.fold(
              (failure) => AuthenticationFail(message: failure.message),
              (tokenUser) => Authenticated(tokenUser: tokenUser),
            );
          }
        }
      );

    } else if (event is SignOut) {
      final result = await socialAuthRepository.googleSignOut();

      yield result.fold(
        (_) => state,
        (_) => Unauthenticated()
      );
    }
  }
}
