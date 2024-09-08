import 'package:chatapp/Domain/Repostory/RepostoryLogin.dart';

class Loginusercase {
  final RepostoryloginDomain repostoryloginDomain;
  Loginusercase({required this.repostoryloginDomain});

  Future<void> call({required String email, required String password}) async {
    await repostoryloginDomain.baseRepostorLogin(email: email, password: password);
  }
}
