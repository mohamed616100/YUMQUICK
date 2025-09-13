import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/search/data/models/search_cubit.dart';
import 'package:yumquick/features/search/views/search_item_listview.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late FocusNode _searchFocus;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchFocus = FocusNode();
    _searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        backgroundColor: Appcolors.primarycolor,
        body: BaseBody(
          height: 131.h,
          childcontiner: Padding(
            padding: AppPaddings.Appbarhorizontalsymatric,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    MyNavigator.goBack(context);
                  },
                  icon: CustomSvg(
                    path: AppIcons.BackiconArrow,
                    width: 8.w,
                    height: 13.h,
                  ),
                ),
                Builder(
                  builder: (context) {
                    return SizedBox(
                      width: 250.w,
                      height: 30.h,
                      child: TextFormField(
                        controller: _searchController,
                        focusNode: _searchFocus,
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 16.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            SearchCubit.get(context).onSearch(q: value);
                          }
                        },
                      ),

                    );
                  }
                )
              ],
            ),
          ),
          body: Column(
            children: [
              SearchItemListview()
            ],
          ),
        ),
      ),
    );
  }
}
