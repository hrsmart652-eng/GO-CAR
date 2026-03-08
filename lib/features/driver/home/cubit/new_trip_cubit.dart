import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/features/driver/home/repository/new_trip_repository.dart';
import 'new_trip_state.dart';

class NewTripCubit extends Cubit<NewTripState> {
 static NewTripCubit get(context)=>BlocProvider.of<NewTripCubit>(context);
  NewTripCubit(this.newTripRepository) : super(NewTripInitial());
  final NewTripRepository newTripRepository;

  getNewTrip() async {
    emit(NewTripLoading());
    final response = await newTripRepository.getNewTrip();
    response.fold(
      (errorMessage) => emit(NewTripFailure(errMessage: errorMessage)),
      (trips) => emit(NewTripSuccess(trips: trips)), // pass the list
    );
  }
}
