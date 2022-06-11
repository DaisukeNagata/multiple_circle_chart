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
              Navigator.of(context).popUntil((route) => route.isFirst);
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
  OverLappingState createState() => OverLappingState();
}

class OverLappingState extends State<OverLappingWidget> {
  final int count = 10;
  OverlapViewModel viewModel = OverlapViewModel();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).size.width / count) * OverlapLineModel.wLines;
    double gridValue =
        (MediaQuery.of(context).size.width / count) * OverlapLineModel.wLines;
    double sizeValue = (MediaQuery.of(context).size.width / count);

    Shader shader = LinearGradient(
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
                sizeValue,
                gridValue,
                1,
                Colors.blue,
                viewModel.model.indexList,
                gradient: viewModel.model.lineOrFillFlg ? null : shader,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: sizeValue, left: w / 2),
              child: CustomPaint(
                painter: viewModel.goalPainter(gridValue),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              viewModel.indexListLogic();
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
        )
      ],
    );
  }
}
