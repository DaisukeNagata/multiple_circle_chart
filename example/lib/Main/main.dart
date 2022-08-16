import 'package:example/Main/main_view_model.dart';
import 'package:flutter/material.dart';

import '../Overlapping/overlapping_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with CallBackLogic {
  MainViewModel mModel = MainViewModel();

  @override
  void initState() {
    super.initState();
    _initStream();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mModel.circleSet(
      MediaQuery.of(context).size.width,
    );
    mModel.viewModel.circleData.circleDefaultTapValue = 1.2;
  }

  @override
  DesignTypeCallBack? callback(
    type, {
    double? max,
    double? value,
    RangeValues? values,
    bool? flg,
  }) {
    setState(() {
      double width = MediaQuery.of(context).size.width;
      switch (type) {
        case DesignType.wSliderState:
          mModel.wSliderState(values);
          break;
        case DesignType.combineState:
          mModel.combineState(width, max, value);
          break;
        case DesignType.knobState:
          mModel.knobState(width, flg);
          break;
        case DesignType.knobRoundState:
          mModel.knobRoundState(width, flg);
          break;
        case DesignType.circleDesignState:
          mModel.circleDesignState(width, flg ?? false);
          break;
      }
    });
    return null;
  }

  _initStream() {
    mModel.viewModel.controller.counterStream.listen((event) {
      setState(() {
        mModel.viewModel.circleLabelValue = (event * 100);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return OverLappingBar();
                  },
                ),
              );
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
          controller: mModel.viewModel.scrollController,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: mModel.viewModel.topBottom,
                ),
              ),
              mModel.stack(),
              mModel.sliderSets(
                callback,
                MediaQuery.of(context).size.width,
              ),
              mModel.setRow(),
              mModel.switchSetRow(callback),
            ],
          ),
        ),
      ),
    );
  }
}
