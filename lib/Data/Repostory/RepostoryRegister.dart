import 'package:chatapp/Data/dataSoures/Auth/Registory.dart';
import 'package:chatapp/Domain/Repostory/RepostoryRegstor.dart';
import 'package:chatapp/error/Error.dart';

class Repostoryregister extends RepostoryregstorDomain {
  final BaseRegistorDataSource baseRegistorDataSource;
  Repostoryregister({required this.baseRegistorDataSource});
  @override
  Future baseRepostoryregstor({
    required String email,
    required String password,
    required String username,
    required imgPath,
    required String imgName,
  }) async {
    try {
      await baseRegistorDataSource.registor(
          email: email,
          password: password,
          username: username,
          imgPath: imgPath,
          imgName: imgName);
    } on ErrorFirebase catch (e) {
      throw e.error;
    }
  }
}
