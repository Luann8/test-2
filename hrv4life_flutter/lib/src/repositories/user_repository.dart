import 'package:hrv4life_core/hrv4life_core.dart';

abstract interface class UserRepository {
   Future<Either<AuthException,String>> login(String email, String password);
}