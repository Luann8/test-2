// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hrv4life_core/hrv4life_core.dart';
import 'package:hrv4life_flutter/src/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_login_service.dart';

class UserLoginServicesImpl implements UserLoginServices {


  UserLoginServicesImpl({
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Future<Either<ServiceException, Unit>> execute(String email, String password) async {
      final loginResult = await userRepository.login(email, password);

      switch(loginResult){
        case Left(value: AuthError()):
          return Left(ServiceException(message: 'Erro ao realizar Login'));
          
        case Left(value: AuthUnauthorizedException()):
          return Left(ServiceException(message: 'Usuário ou senha inválidos.'));

        case Right(value : final acessToken):
          final sp = await SharedPreferences.getInstance();
          sp.setString(LocalStorageConstants.accessToken, acessToken);
          return Right(unit);
      }

  }

}
