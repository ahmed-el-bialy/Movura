part of 'person_details_cubit.dart';

@immutable
abstract class PersonDetailsState {}

class PersonDetailsInitial extends PersonDetailsState {}

class PersonDetailsLoading extends PersonDetailsState {}

class PersonDetailsLoaded extends PersonDetailsState {
  final PersonDetailsModel personDetails;

  PersonDetailsLoaded({required this.personDetails});
}

class PersonDetailsError extends PersonDetailsState {
  final String errorMessage;

  PersonDetailsError({required this.errorMessage});
}
