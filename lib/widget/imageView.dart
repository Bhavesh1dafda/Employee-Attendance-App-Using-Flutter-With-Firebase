import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageType { Asset, File, URL }

class ImageView extends StatefulWidget {
  final String path;
  final ImageType type;
  final double? height, width;
  final double? heightPlaceholder, widthPlaceholder;
  final String placeHolderImagePath;
  final BoxFit fit;
  final BoxFit fitPlaceholder;
  Color? color;

  ImageView(
    this.path,
    this.type, {
    this.height,
    this.color,
    this.width,
    this.heightPlaceholder,
    this.widthPlaceholder,
    this.fitPlaceholder = BoxFit.none,
    this.placeHolderImagePath = "images/icon_placehlder.png",
    this.fit = BoxFit.cover,
  });

  @override
  State<StatefulWidget> createState() {
    return ImageState();
  }
}

class ImageState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return showImage(
      widget.path,
      widget.type,
      widget.height,
      widget.width,
      widget.placeHolderImagePath,
      widget.fit,
      widget.color,
    );
  }

  Widget showImage(String path, ImageType type, double? height, double? width,
      String placeHolderImagePath, BoxFit fit, Color? color) {
    switch (type) {
      case ImageType.Asset:
        try {
          return Image.asset(
            path,
            height: height,
            width: width,
            fit: fit,
          );
        } catch (e) {
          return placeHolder(
            height,
            width,
            placeHolderImagePath,
            fit,
          );
        }
      case ImageType.File:
        try {
          File f = new File(path);
          if (f.existsSync()) {
            return Image.file(
              f,
              height: height,
              width: width,
              fit: fit,
            );
          } else {
            return placeHolder(height, width, placeHolderImagePath, fit);
          }
        } catch (e) {
          return placeHolder(height, width, placeHolderImagePath, fit);
        }
      case ImageType.URL:
        try {
          return Container(
            width: width,
            child: CachedNetworkImage(
              imageUrl: path,
              placeholder: (context, url) =>
                  placeHolder(height, width, placeHolderImagePath, fit),
              errorWidget: (context, url, error) =>
                  placeHolder(height, width, placeHolderImagePath, fit),
              height: height,
              fit: fit,
            ),
          );
        } catch (e) {
          return placeHolder(height, width, placeHolderImagePath, fit);
        }
    }
  }

  Widget placeHolder(
      double? height, double? width, String placeHolderImagePath, BoxFit fit) {
    return Image.asset(
      placeHolderImagePath,
      height: widget.heightPlaceholder ?? height,
      width: widget.widthPlaceholder ?? width,
      color: Colors.grey.shade300,
      // fit: widget.fitPlaceholder,
    );
  }
}
