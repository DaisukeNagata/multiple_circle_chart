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
    double w2 =
        (MediaQuery.of(context).size.width / count) * OverlapLineModel.wLines;
    double w3 = (MediaQuery.of(context).size.width / count);

    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: w2, left: w / 2),
              child: CustomPaint(
                painter: viewModel.graphText(w2),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: w3, left: w / 2),
              child: viewModel.stackLineLogic(
                  w3, w2, Colors.red, viewModel.model.indexList2),
            ),
            Container(
              padding: EdgeInsets.only(top: w3, left: w / 2),
              child: viewModel.stackLineLogic(
                  w3, w2, Colors.blue, viewModel.model.indexList),
            ),
            Container(
              padding: EdgeInsets.only(top: w3, left: w / 2),
              child: CustomPaint(
                painter: viewModel.goalPainter(w2),
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
