import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../imageurl/image.dart';
import '../responsive.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 54.w),
      height: 116.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!Responsive.isDesktop(context))
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(15).w,
                child: const Icon(
                  Icons.menu,
                  color: Colors.grey,
                ),
              ),
            ),
          if (Responsive.isDesktop(context))
            Text(
              "Dashboard",
              style: GoogleFonts.lora(fontSize: 22.sp),
            ),
          SizedBox(
            width: Responsive.isDesktop(context)
                ? MediaQuery.sizeOf(context).width * 0.4
                : MediaQuery.sizeOf(context).width * 0.5,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8).r),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 1, right: 5),
                          hintText: 'Search...',
                          hintStyle: GoogleFonts.lato(fontSize: 14),
                          fillColor: const Color(0xffF3F3F3),
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 18,
                          )),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: Responsive.isDesktop(context) ? 113 : 60,
                    decoration: BoxDecoration(
                        color: const Color(0xff5886FF),
                        borderRadius: BorderRadius.only(
                            topRight: const Radius.circular(10).r,
                            bottomRight: const Radius.circular(10).r)),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
          ),
          Image.asset(
            TImageUrl.imgPerson,
            scale: 1.5,
          )
        ],
      ),
    );
  }
}
