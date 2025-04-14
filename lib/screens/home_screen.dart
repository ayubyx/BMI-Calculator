import 'package:bmi_calculator/provider/theme_provider.dart';
import 'package:bmi_calculator/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMale = true;
  double heightVal = 170.0;
  double weight = 60.0;
  int age = 21;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          centerTitle: true,
          title: Container(
            alignment: Alignment.center,
            width: 106.w,
            height: 30.h,
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                //light
                IconButton(
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .switchToLightMode();
                    },
                    icon: Icon(Icons.light_mode,
                        size: 22.sp,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface)),
                //dark
                IconButton(
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .switchToDarkMode();
                    },
                    icon: Icon(Icons.dark_mode,
                        size: 22.sp,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xFFD9D9D9)
                            : Theme.of(context).colorScheme.primary)),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome 😊",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "BMI Calculator",
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 30),
                    //! Gender
                    Row(
                      spacing: 5.w,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        genderTile(type: "Male"),
                        genderTile(type: "Female"),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    //! Height & weight & age
                    Row(children: [
                      //* Height
                      Container(
                        width: 170.w,
                        height: 360.h,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        margin: EdgeInsets.only(bottom: 5.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Height",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              //color: Colors.red,
                              padding: EdgeInsets.only(
                                  bottom: 10.h, left: 20.w, right: 20.w),
                              height: 300.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //!Slider
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        thumbShape:
                                            SliderComponentShape.noThumb,
                                        overlayShape:
                                            SliderComponentShape.noOverlay,
                                        trackHeight: 15.h,
                                      ),
                                      child: Slider(
                                        value: heightVal,
                                        onChanged: (newVal) {
                                          setState(() {
                                            heightVal = newVal;
                                          });
                                        },
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        inactiveColor: Color(0xFFD1D9E6),
                                        min: 112,
                                        max: 190,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        heightTile(heightNbr: "190"),
                                        heightTile(heightNbr: "180"),
                                        heightTile(heightNbr: "170"),
                                        heightTile(heightNbr: "160"),
                                        heightTile(heightNbr: "150"),
                                        heightTile(heightNbr: "140"),
                                        heightTile(heightNbr: "130"),
                                        heightTile(heightNbr: "120"),
                                        heightTile(heightNbr: "112"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //* Weight
                      SizedBox(width: 20.w),
                      Column(
                        children: [
                          wieghtAgeTile(context, "Weight"),
                          SizedBox(height: 17.h),
                          wieghtAgeTile(context, "Age"),
                        ],
                      )
                    ]),
                    SizedBox(height: 15),
                    //* calcul button
                    MaterialButton(
                      color: Theme.of(context).colorScheme.primary,
                      height: 40.h,
                      minWidth: 385.w,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      onPressed: () {
                        var bmiResult = weight / pow(heightVal / 100, 2);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResultScreen(
                                result: bmiResult, userHeight: heightVal)));
                      },
                      child: Text(
                        "Lets Go",
                        style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    )
                  ])),
        ));
  }

  Container wieghtAgeTile(BuildContext context, String title) {
    return Container(
      width: 188.w,
      height: 170.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20.h),
          Text(
            title == "Age" ? "$age" : weight.toStringAsFixed(0),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //? decrement button
              GestureDetector(
                onTap: () {
                  if (title == "Age") {
                    if (age == 1) {
                    } else {
                      setState(() {
                        age--;
                      });
                    }
                  } else if (weight == 20) {
                  } else {
                    setState(() {
                      weight--;
                    });
                  }
                },
                child: Container(
                  height: 33.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Icon(Icons.remove, size: 24.sp, color: Colors.white),
                ),
              ),
              //? increment button
              GestureDetector(
                onTap: () {
                  if (title == "Age") {
                    setState(() {
                      age++;
                    });
                  } else {
                    setState(() {
                      weight++;
                    });
                  }
                },
                child: Container(
                    height: 33.h,
                    width: 48.w,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Icon(Icons.add, size: 24, color: Colors.white)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget heightTile({required String heightNbr}) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 15.w,
        children: [
          SizedBox(
              width: 52.w,
              child: Divider(
                color: Color(0xFF8C8C8C),
              )),
          Text(
            heightNbr,
            style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8C8C8C)),
          )
        ],
      ),
    );
  }

  Widget genderTile({required String type}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMale = (type == "Male") ? true : false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: 165.w,
        height: 35.h,
        decoration: BoxDecoration(
            color: (isMale && type == "Male") || (!isMale && type == "Female")
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          spacing: 10.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //!Icons
            Icon(type == "Male" ? Icons.male : Icons.female,
                size: 24.sp,
                color:
                    (isMale && type == "Male") || (!isMale && type == "Female")
                        ? Colors.white
                        : Color(0xFF246AFE)),
            //!type
            Text(type,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: (isMale && type == "Male") ||
                          (!isMale && type == "Female")
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                )),
          ],
        ),
      ),
    );
  }
}
