import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlide extends StatelessWidget {
  final List<String> imageList = [
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-2-fertilization_square.png.pagespeed.ce.cePOu_Nvw_.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-3-blastocycst_square.png.pagespeed.ce.NOGV5k4TTs.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-4-yolk-sac_square.png.pagespeed.ce.q6fwFurmNM.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-5-amniotic-sac_square.png.pagespeed.ce.OLFNH5ZFWG.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-6-webbed-hands_square.png.pagespeed.ce.l2duPZXwfW.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-7-tailbone_square.png.pagespeed.ce.f1cllwGROd.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-8-brain-nerve-cells_square.png.pagespeed.ce.l3NjHBrNy1.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-9-finger-touch-pads_square.png.pagespeed.ce.GvC2tnKXWR.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-10-fingernails_square.png.pagespeed.ce.6Z8OiD1KDm.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-11-tooth-buds_square.png.pagespeed.ce.waxXP5_kMn.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-12-eyelids_square.png.pagespeed.ce.qzBvnZUcdM.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-13-fingerprints_square.png.pagespeed.ce.yoIo0dM24b.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-14-face-muscles_square.png.pagespeed.ce.wqIQ2cF5Us.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-15-lung-development_square.png.pagespeed.ce.Xj1BE4OhAo.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-16-heart-development_square.png.pagespeed.ce.Vb7WxrqJ74.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-17-skeleton_square.png.pagespeed.ce.lZWNSC9p0v.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-18-ears_square.png.pagespeed.ce.q9MilAj3Gp.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-19-hair_square.png.pagespeed.ce.lVgvdgq9dg.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-20-fetal-movement_square.png.pagespeed.ce.usZaS6TLZE.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-21-eyelid_square.png.pagespeed.ce.Wz9UtTHktE.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-22-eyes_square.png.pagespeed.ce.pSNIpsZt_8.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-23-hearing_square.png.pagespeed.ce.a9O5GyNP6e.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-24-lung-development_square.png.pagespeed.ce.wBLW3sQc2r.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-30-amniotic-fluid_square.png.pagespeed.ce.iDg-7S5R1W.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-34-lung-development_square.png.pagespeed.ce.mEtz3ZKYiD.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-38-eye-color_square.png.pagespeed.ce.MXaqXO1zl1.png',
    'https://www.babycenter.com/ims/2018/06/pregnancy-week-41-amniotic-fluid_square.png.pagespeed.ce.mrZH9qUjEj.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlay: false,
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
