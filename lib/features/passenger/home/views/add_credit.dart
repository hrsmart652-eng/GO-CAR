import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_elevated_btn.dart';


class AddCredit extends StatefulWidget {
  const AddCredit({super.key});

  @override
  State<AddCredit> createState() => _AddCreditState();
}

class _AddCreditState extends State<AddCredit> {
  int selectedCardIndex = -1;
  
  @override
  Widget build(BuildContext context) {
    List<Widget> creditCards = [
    addCreditContainer(Image.asset("assets/images/visa.png") , "Aareal Bank AG " , 0),
    addCreditContainer(Image.asset("assets/images/visa2.png") , "Aareal Bank AG " , 1),
    addCreditContainer(Image.asset("assets/images/visa3.png") , "Aareal Bank AG " , 2),
    addCreditContainer(Image.asset("assets/images/visa4.png") , "Aareal Bank AG " , 3),
    addCreditContainer(Image.asset("assets/images/visa1.png") , "Aareal Bank AG " , 4),
  ];

    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 70.0.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 22.w,
                        color: const Color(0xff266FFF),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 600.h,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                          return creditCards[index];
                        }),
                      ),

                      SizedBox(
                        height: 20.h,
                      ),
                      CustomElevatedBtn(
                        btnName: "Choose",
                        onPressed: () {},
                      )
           


          ],
        ),
      )
    ));

  }
  Widget addCreditContainer(Image image , String text ,int index ){
    final isSelected = selectedCardIndex == index;
    return   Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedCardIndex = index;
            });
          },
          child: Container(
                                          width: double.infinity,
                                          height: 53.h,
                                          decoration: BoxDecoration(
                                              color:isSelected ? Color(0xffF5FAFF) : Colors.white,
                                              borderRadius: BorderRadius.circular(8.r),
                                              border:isSelected ?  Border.all(
                                                color: Color(0xffBBD1FB),
                                                width: 1.w,
                                              ):null , 
                                              boxShadow:  [
                                                BoxShadow(
                                                  color: Color(0xffB4B4B4).withOpacity(0.16),
                                                  spreadRadius: 0,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0),
                                                 
                                                )
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 16.0.w),
                                            child: Row(children: [
                                              image,
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                              Text("Aareal Bank AG " , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 14.sp , color: Color(0xff121212)),),
                                             
                                             
                                            ]),
                                          )),
        ),
                                        SizedBox(height:20.h ,)
      ],
    );
  }
}