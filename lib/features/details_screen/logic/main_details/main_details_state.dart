part of 'main_details_cubit.dart';

@immutable
sealed class MainDetailsState {}

final class MainDetailsInitial extends MainDetailsState {}

final class MainDetailsLoading extends MainDetailsState {}

final class MainDetailsSuccess extends MainDetailsState {
  final MainDetailsModel model;

  MainDetailsSuccess({required this.model});
}

final class MainDetailsFailed extends MainDetailsState {
  final String errorMessage;

  MainDetailsFailed({required this.errorMessage});
}
