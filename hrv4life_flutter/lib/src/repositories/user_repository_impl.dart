import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hrv4life_core/hrv4life_core.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(data: {'access_token': accessToken}) =
          await restClient.unAuth.post(RoutesAssets.auth,
              data: {'email': email, 'password': password, 'admin': true});
               return Right(accessToken);
    } catch (e, s) {
      log('Error ao relizar Login', error: e, stackTrace: s);
      return switch(e){
        DioException(response: Response(statusCode:HttpStatus.forbidden)?) =>
         Left(AuthUnauthorizedException()),
        _ => Left(AuthError(message: 'Erro ao realizar Login')),
      };
    }
  }
}
