import 'package:chatapp/Presination/Contro/BlocAuth/EventsRegisterEventsRegister.dart';

class EventsloginGo extends EventsAuth {
  String email;
  String password;
  EventsloginGo({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}
