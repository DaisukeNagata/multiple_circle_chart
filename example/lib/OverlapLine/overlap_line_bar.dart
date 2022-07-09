import 'package:example/Main/OverlapSmooth/overLapSmoothBar.dart';
import 'package:flutter/material.dart';

import 'overlap_line_model.dart';
import 'overlap_view_model.dart';

class OverLapLineBar extends StatelessWidget {
  const OverLapLineBar({Key? key}) : super(key: key);

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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const OverLapSmoothBar();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
        body: const OverLappingWidget(),
      ),
    );
  }
}

class OverLappingWidget extends StatefulWidget {
  const OverLappingWidget({Key? key}) : super(key: key);

  @override
  OverLappingState createState() => OverLappingState();
}

class OverLappingState extends State<OverLappingWidget>
    with TickerProviderStateMixin {
  final int count = 10;
  OverlapViewModel viewModel = OverlapViewModel();
  late AnimationController controller;
  late Animation<double> animation;
  late Shader shader;
  late double w;
  late double gridValue;
  late double sizeValue;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {
          animation =
              Tween(begin: 0.0, end: controller.value).animate(controller);

          if (controller.value == 1.0) {
            animation = Tween(begin: 0.0, end: 1.0).animate(controller);
          }
        });
      });
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).size.width / count) * OverlapLineModel.wLines;
    gridValue =
        (MediaQuery.of(context).size.width / count) * OverlapLineModel.wLines;
    sizeValue = (MediaQuery.of(context).size.width / count);
    shader = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: const [0.1, 0.3, 0.6],
      colors: [
        Colors.blue,
        Colors.blue.withOpacity(0.6),
        Colors.blue.withOpacity(0.3),
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, sizeValue, gridValue),
    );
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: gridValue, left: w / 2),
              child: CustomPaint(
                painter: viewModel.graphText(gridValue),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: sizeValue, left: w / 2),
              child: viewModel.stackLineLogic(
                animation,
                sizeValue,
                gridValue,
                1,
                Colors.red,
                viewModel.model.indexList2,
                index: 0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: sizeValue, left: w / 2),
              child: viewModel.stackLineLogic(
                animation,
                sizeValue,
                gridValue,
                1,
                Colors.blue,
                viewModel.model.indexList,
                gradient: viewModel.model.lineOrFillFlg ? null : shader,
              ),
            ),
            if (animation.isCompleted) ...[
              Container(
                padding: EdgeInsets.only(top: sizeValue, left: w / 2),
                child: CustomPaint(
                  painter: viewModel.goalPainter(gridValue),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              controller.reset();
              controller.stop();
              viewModel.indexListLogic();
              controller.forward();
            });
          },
          child: const Text('click here'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              viewModel.model.lineOrFillFlg = !viewModel.model.lineOrFillFlg;
            });
          },
          child: const Text('click here line or fill'),
        ),
      ],
    );
  }
}
