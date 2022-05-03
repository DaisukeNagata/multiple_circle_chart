import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';

import 'overlapping_view_model.dart';

class OverLappingBar extends StatelessWidget {
  OverLappingBar({Key? key}) : super(key: key);
  final OverLappingViewModel viewModel = OverLappingViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: viewModel.model.fold = Scaffold(
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
        body: OverLappingWidget(viewModel: viewModel),
      ),
    );
  }
}

class OverLappingWidget extends StatefulWidget {
  const OverLappingWidget({Key? key, required this.viewModel})
      : super(key: key);
  final OverLappingViewModel viewModel;

  @override
  OverLappingBarState createState() => OverLappingBarState();
}

class OverLappingBarState extends State<OverLappingWidget>
    with TickerProviderStateMixin, OverLapCallBackLogic {
  @override
  Widget build(BuildContext context) {
    var dta = widget.viewModel.model.lastIndicator?.radData;
    double width = MediaQuery.of(context).size.width / 1.2;
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          right: 50 * widget.viewModel.model.scale * 3)),
                  Transform.rotate(
                      angle: (dta == RadData.horizontal ? 360 : -90) * pi / 180,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 70)),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.indicator,
                              width,
                              widget.viewModel.model.globalKey),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.indicator2,
                              width,
                              widget.viewModel.model.globalKey2),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.indicator3,
                              width,
                              widget.viewModel.model.globalKey3),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.indicator4,
                              width,
                              widget.viewModel.model.globalKey4),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.indicator5,
                              width,
                              widget.viewModel.model.globalKey5),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.indicator6,
                              width,
                              widget.viewModel.model.globalKey6),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.indicator7,
                              width,
                              widget.viewModel.model.globalKey7),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.indicator8,
                              width,
                              widget.viewModel.model.globalKey8),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.indicator9,
                              width,
                              widget.viewModel.model.globalKey9),
                          widget.viewModel.indicatorRowSet(
                              widget.viewModel.model.lastIndicator,
                              width,
                              widget.viewModel.model.lastGlobalKey),
                          const Padding(padding: EdgeInsets.only(bottom: 70)),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 50 * widget.viewModel.model.scale * 3)),
                ],
              )),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.viewModel.sliderSet(callback, this),
            widget.viewModel.buttonSet(callback, this),
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
          widget.viewModel.model.graphCount = 10;
          widget.viewModel.animationInitState(context, width / 1.2);
          break;
        case OverLapType.slider:
          widget.viewModel.model.scale = value ?? 0;
          widget.viewModel.model.animationController?.forward();
          break;
      }
    });
    return null;
  }
}
