part of 'local_cubit.dart';

abstract class LocalState extends Equatable {
  const LocalState();
  @override
  List<Object> get props => [];
}

class LocalInitial extends LocalState {}

class LocalCreateState extends LocalState {
  final String message;
  const LocalCreateState({required this.message});
}

class LocalOrderCleanState extends LocalState {
  const LocalOrderCleanState();
}

class LocalOrderGetState extends LocalState {
  final List <CartItem>  item;
  const LocalOrderGetState({required this.item});
}

class LocalLoadingState extends LocalState {}

class LocalFailureState extends LocalState {
  final String message;
  const LocalFailureState({required this.message});
}
