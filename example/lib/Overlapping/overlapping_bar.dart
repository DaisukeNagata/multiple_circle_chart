import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';

import 'overlapping_view_model.dart';

class OverLappingBar extends StatelessWidget {
  const OverLappingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('EveryDaySoft_Example'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: const OverLappingWidget(),
      ),
    );
  }
}

class OverLappingWidget extends StatefulWidget {
  const OverLappingWidget({Key? key}) : super(key: key);

  @override
  OverLappingBarState createState() => OverLappingBarState();
}

class OverLappingBarState extends State<OverLappingWidget>
    with TickerProviderStateMixin, OverLapCallBackLogic {
  OverLappingViewModel viewModel = OverLappingViewModel();

  @override
  Widget build(BuildContext context) {
    var dta = viewModel.lastIndicator?.radData;
    double width = MediaQuery.of(context).size.width / 1.2;
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.only(right: 50, top: 50)),
                  Transform.rotate(
                      angle: (dta == RadData.horizontal ? 360 : -90) * pi / 180,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 70)),
                          viewModel.indicatorRowSet(
                              viewModel.indicator, width, viewModel.globalKey),
                          viewModel.indicatorRowSet(viewModel.indicator2, width,
                              viewModel.globalKey2),
                          viewModel.indicatorRowSet(viewModel.indicator3, width,
                              viewModel.globalKey3),
                          viewModel.indicatorRowSet(viewModel.indicator4, width,
                              viewModel.globalKey4),
                          viewModel.indicatorRowSet(viewModel.indicator5, width,
                              viewModel.globalKey5),
                          viewModel.indicatorRowSet(viewModel.indicator6, width,
                              viewModel.globalKey6),
                          viewModel.indicatorRowSet(viewModel.indicator7, width,
                              viewModel.globalKey7),
                          viewModel.indicatorRowSet(viewModel.indicator8, width,
                              viewModel.globalKey8),
                          viewModel.indicatorRowSet(viewModel.indicator9, width,
                              viewModel.globalKey9),
                          viewModel.indicatorRowSet(viewModel.lastIndicator,
                              width, viewModel.lastGlobalKey),
                          const Padding(padding: EdgeInsets.only(bottom: 70)),
                        ],
                      )),
                  const Padding(padding: EdgeInsets.only(left: 50, bottom: 50)),
                ],
              )),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            viewModel.sliderSet(callback, this, viewModel.scale),
            viewModel.buttonSet(callback, this),
          ],
        ),
      ],
    );
  }

  @override
  OverLapCallBack? callback(type, {OverLappingBarState? vsync, double? value}) {
    setState(() {
      switch (type) {
        case OverLapType.graph:
          double width = MediaQuery.of(context).size.width;
          viewModel.graphCount = 10;
          viewModel.animationInitState(context, width / 1.2);
          break;
        case OverLapType.slider:
          viewModel.scale = value ?? 0;
          viewModel.animationController?.forward();
          break;
      }
    });
    return null;
  }
}
