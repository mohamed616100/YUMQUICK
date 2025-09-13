
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/features/Auth/data/models/login_response_model.dart';
import 'package:yumquick/features/Home/views/home_body.dart';
import 'package:yumquick/features/menu/views/menu_body.dart';
import 'package:yumquick/features/order/views/order_body.dart';

class MainHomeView extends StatefulWidget {
  final UserModel? datauser;
  const MainHomeView({super.key, this.datauser});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}
class _MainHomeViewState extends State<MainHomeView> {
  int selectedIndex = 0;
  late PageController _pageController;
  late final List<Widget> pages;

  final List<String> icons = [
    AppIcons.homeicon,
    AppIcons.menuicon,
    AppIcons.UserIcon,
  ];

  final List<String> labels = [
    "Home",
    "Menu",
    "Orders",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
    pages = [
      HomeBody(
        datauser: widget.datauser,
      ),
      MenuBody(),
      OrderBody(

      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primarycolor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Appcolors.secondarycolor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutBack,
                padding: EdgeInsets.symmetric(
                    horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? Appcolors.textcolorblack: Colors.transparent,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icons[index],
                      width: 24.w,
                      height: 24.h,
                      color: isSelected ? Colors.white : Appcolors.textcolorblack,
                    ),
                    if (isSelected) ...[
                      SizedBox(width: 6.w),
                      Text(
                        labels[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          }),
        ),
      ),
);
  }
}
