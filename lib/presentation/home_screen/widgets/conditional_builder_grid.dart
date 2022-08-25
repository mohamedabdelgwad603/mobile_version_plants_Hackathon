import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/core/utils/extentions.dart';
import '../../../core/utils/end_points.dart';
import '../../../models/products_model.dart';
import '../../shared_cubit/app_cubit.dart';
import '../../shared_cubit/app_states.dart';
import '../../shared_widget/default_button.dart';

class ConditionalBuilderGrid extends StatelessWidget {
  const ConditionalBuilderGrid({Key? key, required this.products})
      : super(key: key);
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! AppGetProductsLoadingState,
            builder: (context) => Container(
                  //  height: MediaQuery.of(context).size.height * .5,
                  child: SingleChildScrollView(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 1 / 1.5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(products.length,
                          (index) => buildGridItem(context, products[index])),
                    ),
                  ),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  buildGridItem(BuildContext context, Product product) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Image.network(
                    '$baseUrl${product.imageUrl}',
                    height: 100,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.remove,
                          size: 14,
                        )),
                    Text(
                      "1",
                      style: context.bodyText1,
                    ),
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.add,
                          size: 14,
                        )),
                  ],
                )
              ],
            ),
            Text(
              '${product.name}',
              style: context.subtitle2,
            ),
            Text('${product.price} EGP'),
            DefaultButton(text: 'Add to cart', onpressed: () {})
          ],
        ),
      ),
    );
  }
}
