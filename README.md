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





## Environment

```
Flutter 2.10.4  Dart >=2.16.2 <3.0.0
```


## Introduction

```
Pie charts can be animated for 100% or more.

The bar graph is a graph that overlaps at the specified position.
```

## Features

<img width="800" src="https://user-images.githubusercontent.com/16457165/161848973-8c81e05c-a0e0-4551-90f9-452ee149579c.gif">



<img width="800" src="https://user-images.githubusercontent.com/16457165/161572895-26321ef3-f66b-4a5a-a78d-eda4bb26e044.gif">



## Memory usage


<img width="600" alt="exam ong" src="https://user-images.githubusercontent.com/16457165/161421822-d0f6a0dd-8a29-412d-ad21-2a6ca25c622d.png">



## Getting started

#### Set the value in Dataclass.
```
circleSetProgress = MultipleCircleSetProgress(circle: c);


late CircleDataItem c = CircleDataItem(
    /// circleForwardFlg is forward or reverse.
    true,

    /// CircleShader is an end type circle None has no knob.
    CircleShader.circleNone,

    /// ComplementCircle is the tuning when the circle is changed to large or small.
    0.05,

    /// circleSizeValue.
    _circleSize,

    /// CircleLabelValue is reverse.
    0.0,

    /// circleLabelSpeedValue is speed.
    0.0,

    /// circleCounterValue is forward.
    0.0,

    /// circleSpeedCounterValue is speed.
    0.0,

    /// circleStrokeWidth is the thickness of the circle.
    30.0,

    /// circleShadowValue is The shadow range value
    0.01,

    /// circlePointerValue is The size of the knob.
    15,

    /// circleDuration is circle animation speed
    _speedValue.toInt(),

    /// circleColor is the color of the knob.
    Colors.green,

    /// circleColor is the shadow color of the knob.
    Colors.black,

    /// circleRoundColor is The base color of circleRoundColor.
    Colors.grey,

    /// circleController is CircleProgressController.
    controller,

    /// circleColorList is Determines the gradient color.
    setColor,
  );
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


FloatingActionButton setButton(
      circleForwardFlg, circleCounterValue, circleLabelValue) {
    return FloatingActionButton(
      onPressed: () {
        _scrollController.jumpTo(0.0);
        c.circleForwardFlg = circleForwardFlg;
        c.circleCounterValue = circleCounterValue;
        c.circleLabelSpeedValue = circleLabelValue;
        c.circleLabelValue = circleLabelValue;
        controller.setProgress([c.circleCounterValue, c.circleLabelValue]);
      },
      child: const Icon(Icons.play_circle),
    );
  }
```


## Additional information

https://twitter.com/dbank0208

dbank0208@gmail.com




