import 'package:equatable/equatable.dart';

abstract class RepostoryloginDomain extends Equatable {
  Future baseRepostorLogin({required String email, required String password});
  
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
