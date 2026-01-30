import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/cubit/driver_shift_cubit.dart';
import 'package:go_car/features/driver/home/cubit/driver_shift_state.dart';

class ChooseCar extends StatefulWidget {
  const ChooseCar({super.key});

  // final VoidCallback onStartShift; // Add this line

  @override
  State<ChooseCar> createState() => _ChooseCarState();
}

class _ChooseCarState extends State<ChooseCar> {
  String _selectedCar = 'Black Nissan'; // <-- hold dropdown value locally

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverShiftCubit, DriverShiftState>(
      listener: (context, state) {
        if (state is DriverShiftFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Container(
          width: 327.w,
          height: 250.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose today\'s car !!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff0D3244),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Car',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff0D3244),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  DropdownButtonFormField<String>(
                    value: _selectedCar,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xffD0D5DD)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    autofocus: true,
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Black Nissan',
                        child: Text('Black Nissan'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Silver Cherry',
                        child: Text('Silver Cherry'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCar = value!; // sync with ApiKeys if needed
                      });
                      print("Selected: $value");
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 295.w,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        BlocProvider.of<DriverShiftCubit>(
                          context,
                        ).startShift(carType: _selectedCar);
                        CacheHelper().saveData(
                          key: ApiKeys.carType,
                          value: _selectedCar,
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xff266FFF),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        'Start Shift',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'If there are any changes you can manage that from your profile & At the end of every day please sign the car out.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff0D3244),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
