import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/widgets/custom_elevated_btn.dart';
import 'package:go_car/features/driver/home/views/widgets/ride_type.dart';
import 'package:go_car/features/passenger/schedule_ride/views/payment_screen.dart';
import 'package:intl/intl.dart';

class ScheduleRide extends StatefulWidget {
  const ScheduleRide({super.key});

  @override
  State<ScheduleRide> createState() => _ScheduleRideState();
}

enum RideType { oneWay, returnRide }

class _ScheduleRideState extends State<ScheduleRide> {
  List<List<dynamic>> carsAndNames = [
    ['assets/images/economy_car.svg', "Economy"],
    ["assets/images/large_car.svg", "Large"],
    ["assets/images/vip_car.svg", "VIP"],
    ["assets/images/pet_car.svg", "Pet"],
  ];

  // int currentIndex = 1;
  int selectedIndex = 0;
  int currentCarIndex = 0;
  int currentPassengersIndex = 0;
  int currentLuggageIndex = 0;

  DateTime? _pickupDateTime;
  TimeOfDay? _returnTime;

  RideType _rideType = RideType.returnRide;

  final DateFormat _dateFormat = DateFormat('dd / MM / yyyy HH:mm');

  Future<void> _selectPickupDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _pickupDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          _pickupDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _selectReturnTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _returnTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _returnTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // List of cars and names   ****************************************
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
            bottom: 10,
          ),
          child: SizedBox(
            width: 370.w,
            height: 91.h,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: carsAndNames.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  currentCarIndex = index;
                                });
                              },
                              child: Container(
                                width: 63.w,
                                height: 63.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color:
                                        currentCarIndex == index
                                            ? const Color(0xff344054)
                                            : const Color(0xffE8EEFB),
                                  ),
                                  color: const Color(0xffE8EEFB),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    carsAndNames[index][0],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 7.h),
                            Text(
                              carsAndNames[index][1],
                              style: TextStyle(
                                color: const Color(0xff0D3244),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // Current location   ****************************************
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            color: const Color(0xffEAECF0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Current location',
                        labelStyle: TextStyle(
                          color: const Color(0xff475467),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.all(5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.circle,
                          color: const Color(0xff5F00FB),
                          size: 8.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Where to   ****************************************
                    TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Where to?',
                        labelStyle: TextStyle(
                          color: const Color(0xff475467),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.all(5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.circle,
                          color: const Color(0xff60BF95),
                          size: 8.w,
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    Text(
                      "Ride",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff475467),
                      ),
                    ),

                    // Ride type
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text("One-way"),
                            value: RideType.oneWay,
                            groupValue: _rideType,
                            onChanged: (RideType? value) {
                              setState(() {
                                _rideType = value!;
                              });
                            },
                            activeColor: Color(0xFF266FFF),
                          ),
                        ),

                        Expanded(
                          child: RadioListTile<RideType>(
                            title: Text("Return"),
                            value: RideType.returnRide,
                            groupValue: _rideType,
                            onChanged: (RideType? value) {
                              setState(() {
                                _rideType = value!;
                              });
                            },
                            activeColor: Color(0xFF266FFF),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Text(
                      "Pickup Date",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff6b7785),
                      ),
                    ),

                    // Pickup Date + Time
                    GestureDetector(
                      onTap: _selectPickupDateTime,
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            // labelText: 'Pickup Date',
                            hintText: 'Day / Month / year HH:MM',
                          ),
                          controller: TextEditingController(
                            text:
                                _pickupDateTime != null
                                    ? _dateFormat.format(_pickupDateTime!)
                                    : '',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Return Time (only if "Return" selected)
                    if (_rideType == RideType.returnRide)
                      GestureDetector(
                        onTap: _selectReturnTime,
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              // labelText: 'Return time',
                              hintText: 'HH:MM',
                            ),
                            controller: TextEditingController(
                              text:
                                  _returnTime != null
                                      ? _returnTime!.format(context)
                                      : '',
                            ),
                          ),
                        ),
                      ),

                    SizedBox(height: 30),
                    Text(
                      "Return time",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff6b7785),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      child: Text(
                        "Passengers no.",
                        style: TextStyle(
                          color: const Color(0xff475467),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    // Passengers number.   ****************************************
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              currentPassengersIndex = index;
                            });
                          },
                          child: Container(
                            width: 51.w, // عدّلي حسب الحجم المناسب لك
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color:
                                  currentPassengersIndex == index
                                      ? const Color(0xff266FFF)
                                      : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color:
                                      currentPassengersIndex == index
                                          ? Colors.white
                                          : const Color(0xff04034C),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ), // تباعد بسيط بين العناصر
                            ),
                          ),
                        );
                      }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      child: Text(
                        "Luggage no.",
                        style: TextStyle(
                          color: const Color(0xff475467),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    // Luggage number.   ****************************************
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              currentLuggageIndex = index;
                            });
                          },
                          child: Container(
                            width: 51.w, // عدّلي حسب الحجم المناسب لك
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color:
                                  currentLuggageIndex == index
                                      ? const Color(0xFFCCCCCC)
                                      : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                '$index',
                                style: TextStyle(
                                  color:
                                      currentLuggageIndex == index
                                          ? const Color(0xff959595)
                                          : const Color(0xff04034C),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ), // تباعد بسيط بين العناصر
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: 30.h),

                    CustomElevatedBtn(
                      btnName: 'Send Request',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                //  FloatingActionButton ****************************************
                Positioned(
                  top: 37,
                  right: 15,
                  child: SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: FloatingActionButton.extended(
                      onPressed: () {},
                      backgroundColor: const Color(0xff266FFF),
                      label: SvgPicture.asset(
                        'assets/images/floating_image.svg',
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30.r,
                        ), // زوايا ناعمة أكثر
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
