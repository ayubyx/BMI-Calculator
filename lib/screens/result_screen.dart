import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultScreen extends StatefulWidget {
  final double result;
  final double userHeight;
  const ResultScreen({
    super.key,
    required this.result,
    required this.userHeight,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String get healthness {
    if (widget.result < 18.5) {
      return "UnderWeihgt";
    } else if (widget.result > 18.5 && widget.result < 24.9) {
      return "Normal";
    } else if (widget.result > 25 && widget.result < 29.9) {
      return "OverWeight";
    } else {
      return "Obese";
    }
  }

  Color get statuColor {
    switch (healthness) {
      case "UnderWeight":
        return Colors.amber;
      case "Normal":
        return Colors.green;
      case "OverWeight":
        return Colors.red;
    }
    return Colors.orange;
  }

  String get bmiSummary {
    final bmi = widget.result;
    String category = healthness;
    double minNormal = 18.5 * pow((widget.userHeight / 100), 2);
    double maxNormal = 24.9 * pow((widget.userHeight / 100), 2);

    switch (category) {
      case "UnderWeight":
        return "Your BMI is ${bmi.toStringAsFixed(1)}, indicating your weight is in the Underweight category for adults of your height."
            "For your height, a normal weight range would be from ${minNormal.toStringAsFixed(1)} to ${maxNormal.toStringAsFixed(1)} kilograms.\n\n"
            "Gaining some weight through a balanced diet and strength training may help reach a healthier weight range.";
      case "Normal":
        return "Your BMI is ${bmi.toStringAsFixed(1)}, indicating your weight is in the Normal category for adults of your height.\n\n"
            "For your height, a normal weight range would be from ${minNormal.toStringAsFixed(1)} to ${maxNormal.toStringAsFixed(1)} kilograms.\n\n"
            "Maintaining a healthy weight may reduce the risk of chronic diseases associated with overweight and obesity.";
      case "OverWeight":
        return "Your BMI is ${bmi.toStringAsFixed(1)}, indicating your weight is in the Overweight category for adults of your height.\n\n"
            "For your height, a normal weight range would be from ${minNormal.toStringAsFixed(1)} to ${maxNormal.toStringAsFixed(1)} kilograms.\n\n"
            "Losing some weight through healthy eating and physical activity may help lower your risk of serious health conditions.";
      case "Obese":
      default:
        return "Your BMI is ${bmi.toStringAsFixed(1)}, indicating your weight is in the Obese category for adults of your height.\n\n"
            "For your height, a normal weight range would be from ${minNormal.toStringAsFixed(1)} to ${maxNormal.toStringAsFixed(1)} kilograms.\n\n"
            "It’s recommended to talk with a healthcare provider for guidance on achieving a healthier weight.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leadingWidth: 100.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Back",
                style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white)),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              "Your BMI is",
              style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white),
            ),
          ),
          SizedBox(height: 20.h),
          //! progress result
          Center(
            child: CircularPercentIndicator(
              radius: 150.r,
              progressColor: statuColor,
              percent: (widget.result / 40).clamp(0.0, 1.0),
              animationDuration: Duration.millisecondsPerSecond,
              animation: true,
              lineWidth: 22.w,
              backgroundColor: Colors.white,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                widget.result.toStringAsFixed(1),
                style: GoogleFonts.poppins(
                    fontSize: 80.sp,
                    fontWeight: FontWeight.w600,
                    color: statuColor),
              ),
            ),
          ),
          SizedBox(height: 25.sp),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              healthness,
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.w600, color: statuColor),
            ),
          ),
          SizedBox(height: 30.sp),
          //! infos
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 400.w,
            height: 140.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              bmiSummary,
              style: GoogleFonts.poppins(
                  fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: MaterialButton(
              color: Theme.of(context).colorScheme.primary,
              height: 40.h,
              minWidth: 379.w,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Re-calculate",
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
