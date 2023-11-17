part of 'upload_cubit.dart';

abstract class UploadState extends Equatable {
  const UploadState();
  @override
  List<Object> get props => [];
}

class UploadInitialState extends UploadState {}

class UploadLoadingState extends UploadState {}

class UploadFailureState extends UploadState {
  final String message;
  const UploadFailureState({required this.message});
}

class UploadSuccessfulState extends UploadState {
  final String message;
  const UploadSuccessfulState({required this.message});
}
