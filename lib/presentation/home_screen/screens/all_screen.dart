// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/models/products_model.dart';
import 'package:palnts/presentation/home_screen/widgets/conditional_builder_grid.dart';
import 'package:palnts/presentation/shared_cubit/app_states.dart';

import '../../shared_cubit/app_cubit.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  @override
  Widget build(BuildContext context) {
    //print(allProducts[0].name);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Product> allProducts =
              BlocProvider.of<AppCubit>(context).productsModel.products;
          return ConditionalBuilderGrid(
            products: allProducts,
          );
        });
  }
}
