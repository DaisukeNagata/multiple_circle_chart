<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

[![Pub Version](https://img.shields.io/pub/v/multiple_circle_chart?color=emerald)](https://pub.dev/packages/multiple_circle_chart/versions/)
[![GitHub Stars Count](https://img.shields.io/github/stars/daisukenagata/multiple_circle_chart?logo=github)](https://github.com/daisukenagata/multiple_circle_chart 'Star me on GitHub!')![Profile Views Counter](https://komarev.com/ghpvc/?username=daisukenagata)

## Environment

```
environment:
  sdk: ">=2.19.0 <3.0.0"
```


## Introduction

```
Pie charts can be animated for 100% or more.

The bar graph is a graph that overlaps at the specified position.
```

## Features

<img width="800" src="https://user-images.githubusercontent.com/16457165/161848973-8c81e05c-a0e0-4551-90f9-452ee149579c.gif">

| | |
|---|---|
|<img width="375" src="https://user-images.githubusercontent.com/16457165/166452386-42d2b30c-61f7-4ac7-b750-99f229e474ad.gif">|<img width="375" src="https://user-images.githubusercontent.com/16457165/166452373-5823b8ed-2f48-46b9-b264-8242f92a68ae.gif">|



| | | |
|---|---|---|
|<img width="300" src="https://user-images.githubusercontent.com/16457165/214596746-10e128aa-1c86-48b6-858f-4afdc1233adf.png">|<img width="300" src="https://user-images.githubusercontent.com/16457165/214593111-101dbb1b-4f01-4402-a99f-011160b2f6f1.png">|<img width="300" src="https://user-images.githubusercontent.com/16457165/214593182-d5ea3da6-d4aa-490f-850c-ae0fd860a9f9.png">| 


## Memory usage


<img width="600" alt="exam ong" src="https://user-images.githubusercontent.com/16457165/161421822-d0f6a0dd-8a29-412d-ad21-2a6ca25c622d.png">





## Getting started

#### Set the value in Dataclass.
```
  circleSetProgress = MultipleCircleSetProgress(circle: c);

  late CircleDataItem c = CircleDataItem(

      /// circleForwardFlg is forward or reverse.
      circleForwardFlg: true,

      /// CircleShader is an end type circle None has no knob.
      circleShader: CircleShader.circleNone,

      /// ComplementCircle is the tuning when the circle is changed to large or small.
      complementCircle: 0.05,

      /// circleSizeValue.
      circleSizeValue: _circleSize,

      /// circleStrokeWidth is the thickness of the circle.
      circleStrokeWidth: 30.0,

      /// circleShadowValue is The shadow range value
      circleShadowValue: 0.01,

      /// circleDuration is circle animation speed
      circleDuration: _speedValue.toInt(),

      /// circleColor is the color of the knob.
      circleColor: Colors.green,

      /// circleColor is the shadow color of the knob.
      circleShadowColor: Colors.black,

      /// circleRoundColor is The base color of circleRoundColor.
      circleRoundColor: Colors.grey,

      /// circleController is CircleProgressController.
      circleController: controller,

      /// circleColorList is Determines the gradient color.
      circleColorList: setColor);
```

#### In the double array, the last element and the next element first have the same color and become a gradation.
```
  final List<List<Color>> setColor = [
    [Colors.white, Colors.blue],
    [Colors.blue, Colors.orange],
    [Colors.orange, Colors.yellow],
    [Colors.yellow, Colors.purple],
    [Colors.purple, Colors.lime],
    [Colors.lime, Colors.limeAccent],
    [Colors.limeAccent, Colors.pink],
    [Colors.pink, Colors.brown],
    [Colors.brown, Colors.white],
    [Colors.white, Colors.green],
    [Colors.green, Colors.deepOrangeAccent],
    [Colors.deepOrangeAccent, Colors.lightBlueAccent],
  ];
```

#### Think the set value to the controller of CircleProgressControllerClass.
```

final CircleProgressController controller = CircleProgressController();


  /// Set the animation value, speed, forward direction, and reverse direction in the library.
  OutlinedButton setButton(
      bool forwardFlg, double counterValue, double circleLabelValue) {
    return OutlinedButton(
      onPressed: () {
        _scrollController.jumpTo(0.0);
        c.circleForwardFlg = forwardFlg;
        c.circleCounterValue = counterValue;
        c.circleLabelSpeedValue = circleLabelValue;
        c.circleLabelValue = circleLabelValue;
        controller
            .setProgress([c.circleCounterValue ?? 0, c.circleLabelValue ?? 0]);
      },
      child: const Icon(Icons.play_circle),
    );
  }
```


## Additional information

https://everydaysoft.co.jp

daisuke.nagata@everydaysoft.co.jp




