abstract class LogoutState{}
class LogoutInitial extends LogoutState{}
class LogoutLoading extends LogoutState{}
class LogoutSuccess extends LogoutState{
  final String message;
  LogoutSuccess(this.message);
}
class LogoutError extends LogoutState{
final String error;
LogoutError(this.error);
}