import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/modules/shop_app/login/login_screen.dart';
import 'package:todo_app/shared/componants/componants.dart';
import 'package:todo_app/shared/network/lockal/cache_helper.dart';
import '../../../shared/componants/constance.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding1.png',
        title: 'Explore many products',
        body: 'make an order setting on sofa pay and chose online'),
    BoardingModel(
        image: 'assets/images/onboarding2.png',
        title: 'Amazing Discounts & Offers ',
        body: 'cheaper than your local Supermarket'),
    BoardingModel(
        image: 'assets/images/onboarding3.png',
        title: 'Speedy Doorstep Delivery',
        body: 'You can pay by visa or cash'),
  ];

  bool islast= false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) => {
          if (value!) {navigateAndFinish(context, ShopLoginScreen())}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              onPressed: submit,
              text: 'SKIP')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        islast = true;
                      });
                    } else {
                      setState(() {
                        islast = false;
                      });
                    }
                  },
                  controller: boardController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        dotHeight: 10,
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (islast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.slowMiddle);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          const SizedBox(
            height: 30,
          ),
          Text(model.title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 15,
          ),
          Text(model.body,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
