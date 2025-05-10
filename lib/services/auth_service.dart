import '../models/user_model.dart';

class AuthService {
  // Aquí podrías consultar una base de datos o API más adelante
  static bool login(User user) {
    return user.username == 'admin' && user.password == '1234';
  }
}