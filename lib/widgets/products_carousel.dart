import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class ProductsCarousel extends StatefulWidget {
  const ProductsCarousel({super.key});

  @override
  State<ProductsCarousel> createState() => _ProductsCarouselState();
}

class _ProductsCarouselState extends State<ProductsCarousel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Stack(
        children: <Widget>[
          InkWell(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4.5,
              height: 100,
              child: Column(
                children: [
                  Image.network(
                    'https://cdn.shopify.com/s/files/1/1943/0647/products/samsung-galaxy-z-fold2sd_1024x.jpg?v=1644512941',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      '14 000Fr',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colorBlue,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Positioned(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width / 1.5,
          //     height: 90,
          //     decoration: const BoxDecoration(
          //       color: Colors.black,
          //     ),
          //     child: Row(
          //       children: <Widget>[
          //         Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'HP core i3',
          //               style: Theme.of(context).textTheme.headline4!.copyWith(
          //                     color: colorwhite,
          //                   ),
          //             ),
          //             Text(
          //               '13 000',
          //               style: Theme.of(context).textTheme.headline6!.copyWith(
          //                     color: colorwhite,
          //                   ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
