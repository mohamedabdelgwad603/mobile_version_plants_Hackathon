import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/products_model.dart';
import '../../shared_cubit/app_cubit.dart';
import '../../shared_cubit/app_states.dart';
import '../widgets/conditional_builder_grid.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Product> plants =
            BlocProvider.of<AppCubit>(context).productsModel.plants;
        return ConditionalBuilderGrid(
          products: plants,
        );
      },
    );
  }
}
