// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/core/utils/extentions.dart';
import 'package:palnts/models/products_model.dart';
import 'package:palnts/presentation/shared_widget/default_button.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/end_points.dart';
import '../shared_cubit/app_cubit.dart';
import '../shared_cubit/app_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: Text(
            'My Cart',
            style: context.subtitle2,
          ),
        ),
        body: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = BlocProvider.of<AppCubit>(context);
              List<Product> cartItems = cubit.cartItems;
              var total = 0;
              cartItems.forEach(
                (element) {
                  total += element.price!;
                },
              );
              return ConditionalBuilder(
                  condition: cartItems.isNotEmpty,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return CartItem(
                                        product: cartItems[index],
                                        cubit: cubit);
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: cartItems.length)),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: context.subtitle1,
                                    ),
                                    Text(
                                      '$total  EGP',
                                      style: context.subtitle1
                                          ?.copyWith(color: AppColors.primary),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                DefaultButton(
                                    text: 'Checkout', onpressed: () {})
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  fallback: (context) {
                    return Center(
                      child: Text(
                        "Your cart is empty",
                        style: context.subtitle1,
                      ),
                    );
                  });
            }));
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.product,
    required this.cubit,
  }) : super(key: key);

  final Product product;
  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Image.network(
            '$baseUrl${product.imageUrl}',
            height: 100,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.name}',
                  style: context.subtitle2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${product.price} EGP',
                  style: context.bodyText1?.copyWith(color: AppColors.primary),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 55,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.remove,
                            size: 14,
                            color: AppColors.primary,
                          )),
                      Text(
                        "1",
                      ),
                      InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.add,
                            size: 14,
                            color: AppColors.primary,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: () {
                cubit.removeFromCart(product);
              },
              child: Icon(
                Icons.delete,
                // size: 14,
                color: AppColors.primary,
              )),
        ]),
      ),
    );
  }
}
