abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String fullName;
  final DateTime birthDate;

  const LoginEvent({
    required this.fullName,
    required this.birthDate,
  });
}

class RegisterEvent extends AuthEvent {
  final String fullName;
  final DateTime birthDate;
  final String email;
  final String? disability;

  const RegisterEvent({
    required this.fullName,
    required this.birthDate,
    required this.email,
    this.disability,
  });
}

class CheckAuthEvent extends AuthEvent {
  const CheckAuthEvent();
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
