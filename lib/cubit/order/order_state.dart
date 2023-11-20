part of 'order_cubit.dart';

@immutable
abstract class OrderState extends Equatable{
  @override
  List<Object?> get props => [];
}


class OrderGetState extends OrderState {
  final OrderModel orderModel;
  OrderGetState({required this.orderModel});
}

class OrderGetUserCartState extends OrderState {
  final List<OrderModel> orderModel;
  OrderGetUserCartState({required this.orderModel});
}

class OrderGetUserState extends OrderState {
  final List<UserModel> userModel;
  OrderGetUserState({required this.userModel});
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderFailureState extends OrderState {
  final String message;
  OrderFailureState({required this.message});
}

class OrderSuccessfulState extends OrderState {
  final String message;
  OrderSuccessfulState({required this.message});
}
