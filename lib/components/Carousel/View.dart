import 'dart:async';
import 'dart:io';

import 'package:codeway_case_project/common/StreamListenableBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:video_player/video_player.dart';

import 'Controller.dart';
import 'Image.dart';

class CarouselView extends StatefulWidget {
  @override
  _CarouselViewState createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  CarouselSliderController _controller = CarouselSliderController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    carouselBloc.getNext();
    carouselBloc.getNext();
    _controller.setAutoSliderEnabled(false);
    _timer = nextPageTimer();
  }

  nextPage() {
    _controller.nextPage();
    carouselBloc.getNext();
    if (_timer != null) {
      _timer!.cancel();
      _timer = nextPageTimer();
    }
  }

  Timer nextPageTimer() {

    return Timer(Duration(seconds: 5), nextPage);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamListenableBuilder(
      stream: carouselBloc.stream,
      listener: (value) {},
      builder: (context, snapshot) => _build(context));

  Widget withGesture(Widget child) => GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (details) {
        if (_timer != null) {
          _timer!.cancel();
        }
      },
      onLongPressUp: () {
        if (_timer != null) {
          _timer!.cancel();
          _timer = nextPageTimer();
        }
      },
      onTapUp: (details) {
        _timer!.cancel();
        _timer = nextPageTimer();
      },
      child: child);

  Widget _build(BuildContext context) {
    var urls = carouselBloc.value.urls;
    return CarouselSlider(
      controller: _controller,
      autoSliderTransitionTime: Duration(milliseconds: 500),
      slideTransform: const CubeTransform(),
      onSlideChanged: (index) {
        carouselBloc.setIndex(index);
        _timer!.cancel();

        _timer = nextPageTimer();
      },
      children: urls
          .map((url) => withGesture(CarouselImage(
                key: ValueKey(url),
                url: url,
              )))
          .toList(),
    );
  }
}
