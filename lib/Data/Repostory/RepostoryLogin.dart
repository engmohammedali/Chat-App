import 'package:chatapp/Data/dataSoures/Auth/Login.dart';
import 'package:chatapp/Domain/Repostory/RepostoryLogin.dart';
import 'package:chatapp/error/Error.dart';

class Repostorylogin extends RepostoryloginDomain {
  final BaseLoginDataSource baseLoginDataSource;
  Repostorylogin({required this.baseLoginDataSource});

  @override
  Future baseRepostorLogin(
      {required String email, required String password}) async {
    try {
      await baseLoginDataSource.login(email: email, password: password);
    } on ErrorFirebase catch (e) {
      throw e.error;
    }
  }
}
