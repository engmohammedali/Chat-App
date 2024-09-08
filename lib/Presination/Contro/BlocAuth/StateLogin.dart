import 'package:chatapp/Presination/Contro/BlocAuth/StateRegister.dart';

class StateLoginSuccess extends StateAuth {}

class StateLoginLoading extends StateAuth {}

class StateLoginError extends StateAuth {
  String error;
  StateLoginError({required this.error});
  List<Object?> get props => [error];
}

class StateAuthInit extends StateAuth{}