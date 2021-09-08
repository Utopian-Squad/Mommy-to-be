import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlideExercise extends StatelessWidget {
  final List<String> imageList = [
    'https://i2.wp.com/shebirthsbravely.com/wp-content/uploads/2020/05/Shared-from-Lightroom-mobile-79.jpg?resize=969%2C646&ssl=1',
    'https://pelvicfloorfirst.org.au/wp-content/uploads/2020/12/143-Pose_15_WCF_234_resized.jpg',
    'https://urogyn.coloradowomenshealth.com/images/Photo-Urogyn-Pelvic-floor-exercises-during-pregnancy.jpg',
    'https://previews.123rf.com/images/belchonock/belchonock1811/belchonock181111658/112754469-young-pregnant-woman-in-fitness-clothes-practicing-yoga-at-home-space-for-text.jpg',
    'https://previews.123rf.com/images/belchonock/belchonock1811/belchonock181111577/112754464-young-pregnant-woman-in-fitness-clothes-lifting-dumbbell-at-home-space-for-text.jpg',
    'https://us.123rf.com/450wm/belchonock/belchonock1811/belchonock181112888/112536649-young-pregnant-woman-in-fitness-clothes-practicing-yoga-at-home-space-for-text.jpg?ver=6',
    'http://www.torontoyogamamas.com/uploads/1/9/7/1/19719197/yoga-for-3rd-trimester-06b_orig.jpg',
    'https://image.shutterstock.com/image-photo/pregnant-woman-stretching-legs-training-260nw-1025038918.jpg',
    'https://image.shutterstock.com/image-photo/pregnant-woman-exercising-home-260nw-662197972.jpg',
    'http://www.torontoyogamamas.com/uploads/1/9/7/1/19719197/yoga-for-3rd-trimester-01_orig.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlay: true,
          ),
          items: imageList
              .map((image) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.network(
                          image,
                          width: 1050,
                          height: 350,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
