// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/core/utils/app_colors.dart';
import 'package:palnts/core/utils/extentions.dart';
import 'package:palnts/presentation/home_screen/screens/all_screen.dart';
import 'package:palnts/presentation/home_screen/screens/plants_screen.dart';
import 'package:palnts/presentation/home_screen/screens/seeds_screen.dart';
import 'package:palnts/presentation/home_screen/screens/tools_screen.dart';
import 'package:palnts/presentation/home_screen/widgets/conditional_builder_grid.dart';
import 'package:palnts/presentation/shared_cubit/app_cubit.dart';
import 'package:palnts/presentation/shared_cubit/app_states.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/utils/constants.dart';
import '../../../network/local/cashe_helper.dart';
import '../../search/search_screen.dart';
import '../../sign_layout/screens/sign_layout_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int barIndex = 0;
  List<String> titles = ['All', 'Plants', 'Seeds', 'Tools'];
  List<Widget> homeScreens = [
    AllScreen(),
    PlantsScreen(),
    SeedsScreen(),
    ToolsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onTap: () {
                    Constants.push(context, SearchScreen());
                  },
                  decoration: InputDecoration(
                      hintText: "search",
                      hintStyle: context.caption,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: BlocConsumer<AppCubit, AppStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return ConditionalBuilder(
                        condition: state is! LoadingAppLogoutState,
                        builder: (context) => InkWell(
                              onTap: () {
                                BlocProvider.of<AppCubit>(context)
                                    .logout(context);
                              },
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                        fallback: (context) => CircularProgressIndicator(
                              color: Colors.white,
                            ));
                  },
                ))
          ]),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  4,
                  (index) => InkWell(
                        onTap: () {
                          setState(() {
                            barIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: barIndex == index
                                  ? Border.all(color: AppColors.primary)
                                  : Border.all(
                                      width: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            titles[index],
                            style: TextStyle(
                                color: barIndex == index
                                    ? AppColors.primary
                                    : Colors.black),
                          ),
                        ),
                      ))),
        ),

        Expanded(child: homeScreens[barIndex]),
        // IndexedStack(
        //   index: barIndex,
        //   children: homeScreens,
        // )
      ],
    );
  }
}
