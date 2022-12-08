import 'function.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    _recorder.initialize();
  }

  var userInput = '0000';
  var responseText = '';
  var answer = '00000';
  final RecorderStream _recorder = RecorderStream();
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;

  void streamingRecognize() async {
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      _audioStream!.add(event);
    });

    await _recorder.start();

    setState(() {
      recognizing = true;
    });
    final serviceAccount = ServiceAccount.fromString(
        (await rootBundle.loadString('assets/test_service_account.json')));
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig();

    final responseStream = speechToText.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _audioStream!);

    responseStream.listen((data) {
      final currentText =
          data.results.map((e) => e.alternatives.first.transcript).join('\n');

      if (data.results.first.isFinal) {
        responseText += '\n' + currentText;
        setState(() {
          text = responseText;
          recognizeFinished = true;
        });
      } else {
        setState(() {
          text = responseText + '\n' + currentText;
          recognizeFinished = true;
        });
      }
    }, onDone: () {
      setState(() {
        recognizing = false;
      });
    });
  }

  void stopRecording() async {
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    setState(() {
      recognizing = false;
    });
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'th-TH');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text("",
              style: TextStyle(fontSize: 25, color: Color(0xFF57636C))),
          backgroundColor: Color(0xFFF1F4F8),
          iconTheme: IconThemeData(color: Color(0xFF57636C)),
          actions: [
            PopupMenuButton(

                //icon: Icon(Icons.more_vert,color: Color(0xFF57636C)),
                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Speech",
                      style: TextStyle(color: Color(0xFF57636C))),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Calculator",
                      style: TextStyle(color: Color(0xFF57636C))),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              } else if (value == 1) {
                stopRecording();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SET()));
              }
            }),
          ],
        ),
        backgroundColor: Color(0xFFF1F4F8),
        body: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: <Widget>[
              Expanded(
                //flex: 2,
                //child: FittedBox(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.centerRight,
                              
                                child: Text(
                                  responseText.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xFF57636C)),
                                ),
                              ),
                          Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.centerRight,
                              
                                child: Text(
                                  answer,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Color(0xFF101213),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                        ]),
                  ),
                ),
                //)
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    //color: Colors.blue,
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.all(100),
                            child: ElevatedButton(
                              child: recognizing
                                  ? FittedBox(
                                      child: Icon(Icons.stop, size: 200))
                                  : FittedBox(
                                      child: Icon(Icons.mic, size: 200)),
                              onPressed: recognizing
                                  ? stopRecording
                                  : streamingRecognize,
                              style: ElevatedButton.styleFrom(
                                primary: recognizing
                                    ? Color.fromARGB(255, 242, 209, 117)
                                    : Color(0xFF7BCFFF),
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(20),
                              ),
                            ))),
                  )),
            ],
          );
        }));
  }

  void equalPressed() {
    String finaluserinput(String str) {
      str = str.replaceAll('x', '*');
      str = str.replaceAll('%', '/100*');
      return str;
    }

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput(userInput));

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toStringAsFixed(5);
    //answer = eval.toString();
    //answer = j.toString();
    //toStringAsExponential(3);
  }
}
