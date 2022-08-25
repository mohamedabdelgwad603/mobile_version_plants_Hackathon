import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/products_model.dart';
import '../../shared_cubit/app_cubit.dart';
import '../../shared_cubit/app_states.dart';
import '../widgets/conditional_builder_grid.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Product> tools =
              BlocProvider.of<AppCubit>(context).productsModel.tools;
          return ConditionalBuilderGrid(
            products: tools,
          );
        });
  }
}
