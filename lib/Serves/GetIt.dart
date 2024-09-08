import 'package:chatapp/Data/Repostory/RepostoryLogin.dart';
import 'package:chatapp/Data/Repostory/RepostoryRegister.dart';
import 'package:chatapp/Data/dataSoures/Auth/Login.dart';
import 'package:chatapp/Data/dataSoures/Auth/Registory.dart';
import 'package:chatapp/Domain/Repostory/RepostoryLogin.dart';
import 'package:chatapp/Domain/Repostory/RepostoryRegstor.dart';
import 'package:chatapp/Domain/UseCases/LoginUserCase.dart';
import 'package:chatapp/Domain/UseCases/RegisterUseCases.dart';
import 'package:chatapp/Presination/Contro/BlocAuth/BlocAuth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class MyGetit {
  void init() {
    //=================Register==============================================================
    getIt.registerLazySingleton<BaseRegistorDataSource>(
        () => RemoteRegistorDataSource());
    getIt.registerLazySingleton<RepostoryregstorDomain>(
        () => Repostoryregister(baseRegistorDataSource: getIt()));
    getIt.registerLazySingleton(
        () => Registerusecases(repostoryregstor: getIt()));

//===================Login====================================================

    getIt.registerLazySingleton<BaseLoginDataSource>(
        () => RemoteLoginDataSource());
    getIt.registerLazySingleton<RepostoryloginDomain>(
        () => Repostorylogin(baseLoginDataSource: getIt()));
    getIt.registerLazySingleton(
        () => Loginusercase(repostoryloginDomain: getIt()));
//===================Bloc ===================================
    getIt.registerFactory(
        () => BlocAuth(registerusecases: getIt(), loginusercase: getIt()));
  }
}
