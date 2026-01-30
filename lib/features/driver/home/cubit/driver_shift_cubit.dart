import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/model/driver_shift_model.dart';
import 'package:go_car/features/driver/home/repository/driver_shift_repository.dart';
import 'driver_shift_state.dart';

class DriverShiftCubit extends Cubit<DriverShiftState> {
  DriverShiftCubit(this.ShiftRepository) : super(DriverShiftInitial());
  final DriverShiftRepository ShiftRepository;

  DriverShiftModel? driver;
  startShift({required String carType}) async {
    emit(DriverShiftLoading());
    final response = await ShiftRepository.startShift(
      id: CacheHelper().getData(key: 'id'),
      carType: carType,
      // shiftId: CacheHelper().getData(key: '_id'),
    );

    response.fold(
      (errorMessage) => emit(DriverShiftFailure(errMessage: errorMessage)),
      (DriverShiftModel) => emit(DriverShiftSuccess()),
    );
  }

  endShift() async {
    emit(DriverShiftLoading());
    final response = await ShiftRepository.endShift(
      id: CacheHelper().getData(key: ApiKeys.shiftId),
    );

    response.fold(
      (errorMessage) => emit(DriverShiftFailure(errMessage: errorMessage)),
      (DriverShiftModel) => emit(DriverShiftSuccess()),
    );
  }

  beOnline() async {
    emit(DriverShiftLoading());
    final response = await ShiftRepository.driverBeOnline(
      id: CacheHelper().getData(key: ApiKeys.id),
    );

    response.fold(
      (errorMessage) => emit(DriverShiftFailure(errMessage: errorMessage)),
      (DriverShiftModel) => emit(DriverShiftSuccess()),
    );
  }

  beOffline() async {
    emit(DriverShiftLoading());
    final response = await ShiftRepository.driverBeOffline(
      id: CacheHelper().getData(key: ApiKeys.id),
    );

    response.fold(
      (errorMessage) => emit(DriverShiftFailure(errMessage: errorMessage)),
      (DriverShiftModel) => emit(DriverShiftSuccess()),
    );
  }

  acceptCash() async {
    emit(DriverShiftLoading());
    final response = await ShiftRepository.driverAcceptCash(
      id: CacheHelper().getData(key: ApiKeys.id),
    );

    response.fold(
      (errorMessage) => emit(DriverShiftFailure(errMessage: errorMessage)),
      (DriverShiftModel) => emit(DriverShiftSuccess()),
    );
  }

  refuseCash() async {
    emit(DriverShiftLoading());
    final response = await ShiftRepository.driverRefuseCash(
      id: CacheHelper().getData(key: ApiKeys.id),
    );

    response.fold(
      (errorMessage) => emit(DriverShiftFailure(errMessage: errorMessage)),
      (DriverShiftModel) => emit(DriverShiftSuccess()),
    );
  }
}
