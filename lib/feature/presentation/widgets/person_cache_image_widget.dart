import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PersonCacheImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const PersonCacheImage(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height});

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      placeholder: ((context, url) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      errorWidget: (context, url, error) {
        return _imageWidget(const AssetImage('assets/image/noimage.jpg'));
      },
    );
  }
}
