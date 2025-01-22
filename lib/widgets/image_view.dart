import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class SliderShowFullmages extends StatefulWidget {
  const SliderShowFullmages({super.key, required this.image});

  final List image;

  @override
  State<SliderShowFullmages> createState() => _SliderShowFullmagesState();
}

class _SliderShowFullmagesState extends State<SliderShowFullmages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(0.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: ImageSlideshow(
                        width: double.infinity,
                        height: 200,
                        initialPage: 0,
                        children: [
                          for (var i = 0; i < widget.image.length; i++)
                            Image.network(
                              widget.image[i],
                              fit: BoxFit.contain,
                            ),
                        ],
                      ),
                    )
                    // PhotoView(
                    //   imageProvider: NetworkImage(this.widget.url),
                    // )
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
