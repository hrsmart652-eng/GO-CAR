// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_car/core/routing/routes.dart';
// import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
// import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';
//
// import '../../../../core/widgets/custom_app_bar.dart';
// import '../../../../core/widgets/custom_elevated_btn.dart';
//
// class AddNewCard extends StatelessWidget {
//   AddNewCard({super.key});
//
//   int selectedCardIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<NormalRideCubit, RequestRideState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         final cubit = NormalRideCubit.get(context);
//         return Scaffold(
//           appBar: customAppBar(title: ''),
//           body: Container(
//             height: double.infinity,
//             color: Colors.white,
//             child: Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 15.h),
//
//                       addVisaContainer(
//                         Image.asset(
//                           "assets/images/visa.png",
//                           width: 38.w,
//                           height: 38.h,
//                         ),
//                         "Aareal Bank AG",
//                         1,
//                         () {
//                           selectedCardIndex = 1;
//                           cubit.selectVisaBank(index: selectedCardIndex);
//                         },
//                       ),
//                       SizedBox(height: 20.h),
//                       addVisaContainer(
//                         Image.asset(
//                           "assets/images/visa1.png",
//                           width: 38.w,
//                           height: 38.h,
//                         ),
//                         "BIGBANK AS Sverige Filial",
//                         2,
//                         () {
//                           selectedCardIndex = 2;
//                           cubit.selectVisaBank(index: selectedCardIndex);
//                         },
//                       ),
//                       SizedBox(height: 20.h),
//                       addVisaContainer(
//                         Image.asset(
//                           "assets/images/visa2.png",
//                           width: 38.w,
//                           height: 38.h,
//                         ),
//                         "HSBC Continental Europe Bank",
//                         3,
//                         () {
//                           selectedCardIndex = 3;
//                           cubit.selectVisaBank(index: selectedCardIndex);
//                         },
//                       ),
//                       SizedBox(height: 20.h),
//                       addVisaContainer(
//                         Image.asset(
//                           "assets/images/visa3.png",
//                           width: 38.w,
//                           height: 38.h,
//                         ),
//                         "Barclays Bank Ireland PLC",
//                         4,
//                         () {
//                           selectedCardIndex = 4;
//                           cubit.selectVisaBank(index: selectedCardIndex);
//                         },
//                       ),
//                       SizedBox(height: 20.h),
//                       addVisaContainer(
//                         Image.asset(
//                           "assets/images/visa4.png",
//                           width: 38.w,
//                           height: 38.h,
//                         ),
//                         "BNP Paribas S.A., Bankfilial Sverige",
//                         5,
//                         () {
//                           selectedCardIndex = 5;
//                           cubit.selectVisaBank(index: selectedCardIndex);
//                         },
//                       ),
//                       SizedBox(height: 20.h),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 40.h,
//                   left: 8.w,
//                   child: CustomElevatedBtn(
//                     btnName: 'Choose',
//                     onPressed: () {
//                       Navigator.pushNamed(context, Routes.paymentMethod);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget addVisaContainer(
//     Image image,
//     String text,
//     int index,
//     void Function()? onTap,
//   ) {
//     bool isSelected = selectedCardIndex == index;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         height: 50.h,
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xffF5FAFF) : Colors.white,
//           borderRadius: BorderRadius.circular(8.r),
//           border:
//               isSelected
//                   ? Border.all(color: Color(0xffBBD1FB), width: 1.w)
//                   : null,
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xffB4B4B4).withOpacity(0.16),
//               spreadRadius: 0,
//               blurRadius: 10,
//               offset: Offset(0, 0),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(left: 16.w),
//           child: Row(
//             children: [
//               image,
//               SizedBox(width: 16.w),
//               Text(
//                 text,
//                 style: TextStyle(
//                   fontFamily: "Cairo",
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0,
//                   color: Color(0xff121212),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
