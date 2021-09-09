import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlideFood extends StatelessWidget {
  final List<String> imageList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOFfjSNFbSyhpqUxIq4GBKiRSOQ2RklIzZvLahoBt1oF-nqB0RYLciSwaQUBHpV_6HDqI&usqp=CAU',
    'https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/7/0/4/4/1094407-1-eng-GB/Iran-Healthy-eating-good-for-mental-health-B-vits-omega-3s-highlighted_wrbm_large.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWSkZn7KrvbWiJMo4ITY_ZWvRtcZVDnRpTtlaKym3xhNthYapT_zvmOy8-w_pF8Daxw-g&usqp=CAU',
    'https://media.istockphoto.com/photos/varied-food-carbohydrates-protein-vegetables-fruits-dairy-legumes-on-picture-id1220784936',
    'https://cdn1.vectorstock.com/i/1000x1000/88/75/pregnancy-healthy-unhealthy-eating-choices-banner-vector-27228875.jpg',
    'https://babybumpbundle.com/wp-content/uploads/2014/03/Pregnancy-Nutrition.jpg'
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
