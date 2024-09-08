import 'package:bloc/bloc.dart';
import 'package:chatapp/Domain/UseCases/LoginUserCase.dart';
import 'package:chatapp/Domain/UseCases/RegisterUseCases.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/EventsLogin.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/EventsRegisterEventsRegister.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/StateLogin.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/StateRegister.dart';

class BlocAuth extends Bloc<EventsAuth, StateAuth> {
  final Registerusecases registerusecases;
  final Loginusercase loginusercase;
  BlocAuth({required this.registerusecases, required this.loginusercase})
      : super(StateAuthInit()) {
    eventsRegister();
    eventsLogin();
  }
  void eventsLogin() => on<EventsloginGo>((event, emit) async {
        emit(StateLoginLoading());

        try {
          await loginusercase.call(
              email: event.email, password: event.password);
          emit(StateLoginSuccess());
        } catch (e) {
          emit(StateLoginError(error: e.toString()));
        }
      });

  void eventsRegister() => on<EventsRegisterGo>((event, emit) async {
        emit(StateregisterLoading());

        try {
          await registerusecases.call(email:event. email, password: event.password, username:event. username, imgPath:event. imgPath, imgName: event.imgName);
          emit(StateregisterSuccess());
        } catch (e) {
          emit(StateregisterError(error: e.toString()));
        }
      });
}
