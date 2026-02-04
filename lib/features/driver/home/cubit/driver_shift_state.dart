class DriverShiftState {}

final class DriverShiftInitial extends DriverShiftState {}

final class DriverShiftLoading extends DriverShiftState {}

final class DriverShiftSuccess extends DriverShiftState {}

final class DriverShiftFailure extends DriverShiftState {
  final String errMessage;
  DriverShiftFailure({required this.errMessage});
}
