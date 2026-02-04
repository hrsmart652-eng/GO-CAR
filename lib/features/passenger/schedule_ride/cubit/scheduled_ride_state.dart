class ScheduledRideState {}

final class ScheduledRideInitial extends ScheduledRideState {}

final class ScheduledRideLoading extends ScheduledRideState {}

final class ScheduledRideSuccess extends ScheduledRideState {}

final class ScheduledRideFailure extends ScheduledRideState {
  final String errMessage;

  ScheduledRideFailure({required this.errMessage});
}
