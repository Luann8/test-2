
import 'package:hrv4life_core/hrv4life_core.dart';

abstract interface class UserLoginServices {
  Future<Either<ServiceException, Unit>> execute(String email, String password);
}