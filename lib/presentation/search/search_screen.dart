import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/core/utils/extentions.dart';

import '../shared_cubit/app_cubit.dart';
import '../shared_cubit/app_states.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isTap = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<AppCubit>(context);
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      style: context.bodyText1,
                      onTap: () {
                        setState(() {
                          isTap = true;
                        });
                      },
                      onChanged: (v) {
                        setState(() {
                          isTap = false;
                        });
                      },
                      onFieldSubmitted: (value) {
                        cubit.addToRecentSearches(value);
                        setState(() {
                          isTap = false;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "search",
                          hintStyle: context.caption,
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (cubit.recentSearches.isNotEmpty && isTap)
                    Text(
                      "Recent Searches",
                      style: context.caption,
                    ),
                  if (cubit.recentSearches.isNotEmpty && isTap)
                    Expanded(
                      child: ListView.builder(
                          itemCount: cubit.recentSearches.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                searchController.text =
                                    cubit.recentSearches[index];
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(cubit.recentSearches[index]),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        cubit.removeFromRecentsearches(index);
                                      },
                                      icon: Icon(Icons.cancel_outlined))
                                ],
                              ),
                            );
                          }),
                    )
                ],
              ),
            ),
          );
        });
  }
}
