import 'package:equatable/equatable.dart';

abstract class StateAuth extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StateregisterSuccess extends StateAuth {}

class StateregisterLoading extends StateAuth {}

class StateregisterError extends StateAuth {
  String error;
  StateregisterError({required this.error});
  List<Object?> get props => [error];
}

class StateregisterInit extends StateAuth {}
