import 'package:calculatorapp/calculate.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'dart:async';


class PageVoice extends StatefulWidget {
  @override
  Voice createState() => Voice();
}

class Voice extends State<PageVoice> {

  @override
  var responseText = '';
  //var userInput = '0000';
  var answer = '0';

  void initState() {
    super.initState();

    _recorder.initialize();
  }

  final RecorderStream _recorder = RecorderStream();
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;

  void streamingRecognize() async {
    // responseText = '';
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
          data.results.map((e) => e.alternatives.first.transcript).join(' ');

      if (data.results.first.isFinal) {
        responseText += '' + currentText;
        setState(() {
          text = responseText;
          recognizeFinished = true;
          // equalPressed();
        });
      } else {
        setState(() {
          text = responseText + '' + currentText;
          recognizeFinished = true;
        });
      }
      print(responseText);
      final splitted = responseText.split(new RegExp(r'(ทั้งหมด)|(ถังหมด)'));
      String result = "";
      for (var i = 1; i < splitted.length; i++) {
        result = result + "(";
      }
      result = result + splitted.map((val) => val.trim()).join(')');
      result = result.replaceAll("หาร", '/');
      result = result.replaceAll("คูณ", '*');
      result = result.replaceAll("บวก", '+');
      result = result.replaceAll("ลบ", '-');
      result = result.replaceAll(new RegExp(r'(เปิดเน็ต)|(เปอร์เซ็นต์)'), '%');
      result = result.replaceAll(new RegExp(r'(%ของ)|(% ของ)'), '/100*');
      responseText = result.replaceAll(new RegExp(r'[^\d\+\-\*/\%()]'), '');
      print(responseText);
    }, onDone: () {
      setState(() {
        equalPressed();
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
  Widget build(BuildContext context) => Scaffold(

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

                              onLongPress: () {setState(() {
                                responseText = '0';
                                answer = '0';
                              });},

                            ))),
                  )),
            ],
          );
        }));
  

  void equalPressed() {
    String finaluserinput(String str) {
      str = str.replaceAll('x', '*');
      str = str.replaceAll('%', '/100');
      return str;
    }

    String input = responseText;
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput(input));

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toStringAsFixed(4);

    print('สมการ exp' + exp.toString());
  }
}