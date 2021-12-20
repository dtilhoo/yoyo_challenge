import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/slider_model.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  List<SliderModel> _slides = <SliderModel>[];
  int _currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _slides = getSlides();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300.0,
            width: double.infinity,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              itemCount: _slides.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SvgPicture.asset(_slides[index].getImage()!),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _slides.length,
              (index) => buildDot(index, context),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: _currentIndex != 0
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              if (_currentIndex != 0)
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: const Text("Previous"),
                  onPressed: () {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  },
                ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                    _currentIndex == _slides.length - 1 ? "Continue" : "Next"),
                onPressed: () {
                  if (_currentIndex == _slides.length - 1) {
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: _currentIndex == index ? 20.0 : 10.0,
      width: _currentIndex == index ? 20.0 : 10.0,
      margin: const EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: _currentIndex == index ? Colors.greenAccent : Colors.blueAccent,
      ),
    );
  }
}
