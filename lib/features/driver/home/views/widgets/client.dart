import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_cubit.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_state.dart';

class ClientDetails extends StatefulWidget {
  int index;

  ClientDetails({super.key, required this.index});

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewTripCubit, NewTripState>(
      listener: (context, state) {
        if (state is NewTripFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return state is NewTripLoading
            ? CircularProgressIndicator()
            : state is NewTripSuccess
            ? state.trips.isEmpty
                ? Center(
                  child: Text(
                    "No new trips available",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
                : Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child:
                          state.trips[widget.index].client!.first.image
                                  // state
                                  ==
                                  null
                              ? CircleAvatar(
                                radius: 50.r,
                                child: Icon(Icons.person, size: 50),
                              )
                              : ClipOval(
                                child: Image.network(
                                  state
                                      .trips[widget.index]
                                      .client!
                                      .first
                                      .image!,
                                  // ??
                                  // 'https://example.com/image.jpg'
                                  width: 45.w,
                                  height: 40.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                    ),

                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.trips[widget.index].client!.first.name ??
                              'Client Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xffF0C24D),
                              size: 20,
                            ),
                            Text(
                              ' 4.4',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
            : SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            );
      },
    );
  }
}
