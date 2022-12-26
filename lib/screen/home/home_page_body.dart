import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommend_product_controller.dart';
import '../../model/popular_product_model.dart';
import '../../resources/AppColors.dart';
import '../../resources/app_constants.dart';
import '../../resources/dimensions.dart';
import '../../routes/router_helper.dart';
import '../../widget/app_column.dart';
import '../../widget/big_text.dart';
import '../../widget/bottom_list_widget_icon_text.dart';
import '../../widget/small_text.dart';
import '../popular_screen.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var curPageValue = 0.0;
  double scaleFactor = 0.8;
  final double _trasHeight = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        curPageValue = pageController.page!;
        //print(curPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (controller) {
            return controller.isLoaded
                ? SizedBox(
                    height: Dimensions.pageView,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: controller.popularProductList.length,
                        itemBuilder: (context, position) => _buildHomePageItem(
                            position, controller.popularProductList[position])),
                  )
                : const CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: curPageValue,
            decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeColor: AppColors.mainColor,
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          );
        }),

        //Popular Segement
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            children: [
              BigText(text: "Popular"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height5),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: SmallText(text: "Food list")),
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProductBuilder) {
          return ListView.builder(
              itemCount:
                  recommendedProductBuilder.recommendedProductList.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          RouterHelper.getRecommendedPageRoute(index, 'Home'));
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      //height: 50,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.height10),
                      child: Row(
                        children: [
                          //image section
                          Container(
                            width: Dimensions.lvImgSize,
                            height: Dimensions.lvImgSize,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        recommendedProductBuilder
                                            .recommendedProductList[index]
                                            .img!))),
                          ),
                          //text section
                          Expanded(
                            child: Container(
                              height: Dimensions.lvTextContainerSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20)),
                                  color: Colors.white),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width20,
                                      right: Dimensions.width10),
                                  child: AppColumn(
                                    text: recommendedProductBuilder
                                        .recommendedProductList[index].name!,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        })
      ],
    );
  }

  Widget _buildHomePageItem(int position, ProductsModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (position == curPageValue.floor()) {
      var curScale = 1 - (curPageValue - position) * (1 - scaleFactor);
      var trans = _trasHeight * (1 - curScale) / 2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, trans, 0);
    } else if (position == curPageValue.floor() + 1) {
      var curScale =
          scaleFactor + (curPageValue - position + 1) * (1 - scaleFactor);
      var trans = _trasHeight * (1 - curScale) / 2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1);
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, trans, 0);
    } else if (position == curPageValue.floor() - 1) {
      var curScale = 1 - (curPageValue - position) * (1 - scaleFactor);
      var trans = _trasHeight * (1 - curScale) / 2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1);
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, trans, 0);
    } else {
      var curScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, _trasHeight * (1 - scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouterHelper.getPopularPageRoute(position, 'HomePage'));
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: Dimensions.pageViewContainer,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: position.isEven ? const Color(0xFF69c5df) : Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProduct.img!))),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(
                left: 30, right: 30, bottom: Dimensions.height10),
            height: Dimensions.pageTextViewContainer,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5,
                      blurStyle: BlurStyle.inner,
                      offset: Offset(0, 5))
                ]),
            child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    left: Dimensions.height15,
                    right: Dimensions.height15,
                    bottom: Dimensions.height10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: popularProduct.name!,
                      color: AppColors.mainBlackColor,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: AppColors.mainColor,
                                      size: Dimensions.height15,
                                    ))),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        SmallText(text: popularProduct.stars.toString()),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        SmallText(text: '1230'),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        SmallText(text: 'Comments')
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BottomListWidgetIconText(
                            iconData: Icons.circle,
                            text: 'Normal',
                            iconColor: AppColors.iconColor1),
                        BottomListWidgetIconText(
                            iconData: Icons.location_on,
                            text: popularProduct.location.toString(),
                            iconColor: AppColors.mainColor),
                        BottomListWidgetIconText(
                            iconData: Icons.access_time_rounded,
                            text: '32 min away',
                            iconColor: AppColors.iconColor2),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ]),
    );
  }
}
