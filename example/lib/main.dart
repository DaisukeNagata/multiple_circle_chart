import 'package:example/main_view_model.dart';
import 'package:flutter/material.dart';

import 'overlapping_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
    mModel.circleSet(context);
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
          mModel.mainCircleDataModel.scrollController.animateTo(
            mModel.mainCircleDataModel.scrollController.offset == 0
                ? mModel.mainCircleDataModel.scrollController.position
                    .maxScrollExtent
                : 0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          );
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          controller: mModel.mainCircleDataModel.scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top:
                          mModel.mainCircleDataModel.paddingValueTopAndBottom)),
              mModel.stack(),
              mModel.textSets(),
              mModel.sliderSets(this, context),
              mModel.setRow(),
              mModel.switchSetRow(this, context),
              Padding(
                  padding: EdgeInsets.only(
                      top: mModel.mainCircleDataModel.paddingValue)),
            ],
          ),
        ),
      ),
    );
  }

  /// setState
  wSlider(values) => setState(() {
        if (mModel.mainCircleDataModel.rValue != values.start) {
          mModel.mainCircleDataModel.rValue = values.start;
        } else if (mModel.mainCircleDataModel.fValue != values.end) {
          mModel.mainCircleDataModel.fValue = values.end;
        }
      });

  /// setState
  sliderSet(max, value, circleCombineFlg) => setState(() {
        if (max == MediaQuery.of(context).size.width) {
          mModel.mainCircleDataModel.circleData.circleSizeValue = value;
          if (!circleCombineFlg) {
            mModel.mainCircleDataModel.circleData.circleStrokeWidth = value / 3;
          }
        } else if (max == 20000) {
          mModel.mainCircleDataModel.speedValue = value;
          mModel.mainCircleDataModel.circleData.circleDuration =
              mModel.mainCircleDataModel.speedValue.toInt();
        }
      });

  /// setState
  combinedState(flg) => setState(() {
        mModel.circleCombinedMethod(context, flg);
      });

  counterStream() {
    /// Show animation values.
    mModel.mainCircleDataModel.controller.counterStream.listen((event) {
      setState(() {
        var e = 0.0;
        if (event != 0.0) {
          e = event;
        }
        mModel.mainCircleDataModel.circleLabelValue = (e * 100);
      });
    });
  }
}
