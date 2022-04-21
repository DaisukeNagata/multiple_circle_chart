import 'package:example/main_view_model.dart';
import 'package:flutter/material.dart';

import 'overlapping_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EveryDaySoft_Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  MainViewModel mModel = MainViewModel();

  @override
  void initState() {
    super.initState();
    counterStream();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mModel.circleSet(context);
  }

  @override
  Widget build(BuildContext context) {
    mModel.dataViewModel.circleData.circleDefalutTapValue = 1.2;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const OverLappingBar();
              }));
            },
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          mModel.scrollAnimation();
        },
        child: SingleChildScrollView(
          controller: mModel.dataViewModel.scrollController,
          child: Column(
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(top: mModel.dataViewModel.padTopBottom)),
              mModel.stack(),
              mModel.sliderSets(this, context),
              mModel.setRow(),
              mModel.switchSetRow(this, context),
            ],
          ),
        ),
      ),
    );
  }

  /// setState
  wSlider(values) => setState(() {
        mModel.wSLiderState(values);
      });

  /// setState
  sliderSet(max, value) => setState(() {
        mModel.combineState(context, max, value);
      });

  /// setState
  circleColorState(flg) => setState(() {
        mModel.circleColorMethod(context, flg);
      });

  /// setState
  circleShaderFlgState(flg) => setState(() {
        mModel.circleShaderFlgMethod(context, flg);
      });

  /// setState
  combinedState(flg) => setState(() {
        mModel.circleCombinedMethod(context, flg);
      });

  counterStream() {
    mModel.dataViewModel.controller.counterStream.listen((event) {
      setState(() {
        mModel.dataViewModel.circleLabelValue = (event * 100);
      });
    });
  }
}
