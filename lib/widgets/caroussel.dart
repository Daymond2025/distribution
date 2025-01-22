import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/couverture_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Caroussel extends StatefulWidget {
  const Caroussel({super.key});

  @override
  State<Caroussel> createState() => _CarousselState();
}

class _CarousselState extends State<Caroussel> {
  List<dynamic> _couvertureList = [];

  Future<void> allCouverture() async {
    ApiResponse response = await getCouvertures();
    if (response.error == null) {
      setState(() {
        _couvertureList = response.data as List<dynamic>;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  @override
  void initState() {
    allCouverture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _couvertureList.isEmpty
        ? Container(
            height: 190,
          )
        : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 0,
              ),
              color: colorwhite,
              child: ImageSlideshow(
                width: double.infinity,
                height: 190,
                initialPage: 0,
                indicatorColor: Colors.blue,
                indicatorBackgroundColor: Colors.grey,
                autoPlayInterval: 2000,
                isLoop: true,
                children: _couvertureList
                    .map(
                      (e) => Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(e['photo']),
                                fit: BoxFit.contain,
                                onError: (exception, stackTrace) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: e['lien'] != null
                                ? Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: colorwhite,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: const Icon(Icons.link),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          );
  }
}
