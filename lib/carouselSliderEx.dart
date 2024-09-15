import 'package:flutter/material.dart';

class CarouselSliderPageView extends StatefulWidget {
  const CarouselSliderPageView({Key? key}) : super(key: key);

  @override
  _CarouselSliderPageViewState createState() => _CarouselSliderPageViewState();
}

class _CarouselSliderPageViewState extends State<CarouselSliderPageView> {
  final PageController _pageController =
      PageController(viewportFraction: 0.8, keepPage: true);
  final List<String> imageUrls = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc4sFdCzkGAqRYxYchjZTNO8vOXkIjAkXb-f0NWaWbrW735yQ_G9L-VAfXIVlB5Csy2oo&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc4sFdCzkGAqRYxYchjZTNO8vOXkIjAkXb-f0NWaWbrW735yQ_G9L-VAfXIVlB5Csy2oo&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc4sFdCzkGAqRYxYchjZTNO8vOXkIjAkXb-f0NWaWbrW735yQ_G9L-VAfXIVlB5Csy2oo&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc4sFdCzkGAqRYxYchjZTNO8vOXkIjAkXb-f0NWaWbrW735yQ_G9L-VAfXIVlB5Csy2oo&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc4sFdCzkGAqRYxYchjZTNO8vOXkIjAkXb-f0NWaWbrW735yQ_G9L-VAfXIVlB5Csy2oo&usqp=CAU",
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 2), () {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
      _startAutoPlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GFG Slider"),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          double scale = 1.0;
          double verticalShift = 0.0;

          if (_pageController.position.haveDimensions) {
            scale = 1.0 - ((_pageController.page! - index).abs() * 0.2);
            scale = scale.clamp(0.8, 1.0);

            verticalShift = (_pageController.page! - index).abs() * 20.0;
            verticalShift = verticalShift.clamp(0.0, 20.0);
          }

          return Center(
            child: Transform.scale(
              scale: scale,
              child: Transform.translate(
                offset: Offset(0.0, -verticalShift),
                child: Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(imageUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
/*
jawline:
https://youtu.be/ySxYAobhlkU?si=nOHyysIwIfLOKtFw
eyelid lift :
https://youtu.be/aiYn51F8sto?si=VU49xhkt-6ofoUgI
small lips:
https://youtu.be/khi_Q1u9Ylc?si=ZQ38bZR3hBgKLevh
nose bridge:
https://youtu.be/WurEm9RzeRQ?si=cOJE25lmXd3CuEiw
face massage:
https://youtu.be/J21EKPOT-Oo?si=EUWQ94tSo4IkO7tH
 */