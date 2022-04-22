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
    mModel.circleSet(MediaQuery.of(context).size.width);
    mModel.viewModel.circleData.circleDefalutTapValue = 1.2;
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
          controller: mModel.viewModel.scrollController,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: mModel.viewModel.padTopBottom)),
              mModel.stack(),
              mModel.sliderSets(this, MediaQuery.of(context).size.width),
              mModel.setRow(),
              mModel.switchSetRow(this),
            ],
          ),
        ),
      ),
    );
  }

  /// setState
  mModelState(DesignType type,
          {double? max, double? value, RangeValues? values, bool? flg}) =>
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

  counterStream() {
    mModel.viewModel.controller.counterStream.listen((event) {
      setState(() {
        mModel.viewModel.circleLabelValue = (event * 100);
      });
    });
  }
}
