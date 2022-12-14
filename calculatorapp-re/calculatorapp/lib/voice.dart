import 'dart:collection';

import 'package:calculatorapp/calculate.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'dart:async';
import 'package:calculatorapp/TextToSpeechAPI.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PageVoice extends StatefulWidget {
  @override
  Voice createState() => Voice();
}

class Voice extends State<PageVoice> {
  @override
  var responseText = '0';
  //var userInput = '0000';
  var answer = '0';
  void initState() {
    super.initState();
    synthesizeText(
        "สวัสดียินดีต้อนรับสู่ Voice Calculator ค่ะ เพื่อเริ่มต้นใช้งาน ท่านสามารถแตะปุ่มกลางหน้าจอและรอสัญญาณได้เลยค่ะ",
        '');
    _recorder.initialize();
  }

  final RecorderStream _recorder = RecorderStream();
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  bool complete_exp = true;
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;
  AudioPlayer audioPlugin = AudioPlayer();

  void synthesizeText(String text, String name) async {
    if (audioPlugin.state == PlayerState.playing) {
      await audioPlugin.stop();
    }

    final String audioContent = await TextToSpeechAPI()
        .synthesizeText(text, 'th-TH-Standard-A', 'th-TH');
    if (audioContent == null) return;
    final bytes = Base64Decoder().convert(audioContent, 0, audioContent.length);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/wavenet.mp3');
    final mp3Uri = file.uri.toString();
    await file.writeAsBytes(bytes);
    await audioPlugin.play(UrlSource(mp3Uri));
  }

  void streamingRecognize() async {
    String text = '';
    // responseText = '';
    synthesizeText("เริ่มตรวจจับเสียง", '');
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      _audioStream!.add(event);
    });
    responseText = answer.toString();
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
          data.results.map((e) => e.alternatives.first.transcript).join('');

      var voicecontrolstop = false;
      if (data.results.first.isFinal || voicecontrolstop) {
        text = '' + currentText;
        print("isFinal : " + text);
        setState(() {
          text = text.replaceAll(' ', '');
          text = text.replaceAll(RegExp(r'(ส่วน)'), '#');
          text = text.replaceAll(RegExp(r'(หาร)|([/])'), '/');
          text = text.replaceAll(
              RegExp(r'(คุณ)|(คูณ)|(เท่า)|(เท่าของ)|([\*])|(x)|(X)'), '*');
          text = text.replaceAll(RegExp(r'(บวก)|(เพิ่ม)|([\+])'), '+');
          text = text.replaceAll(
              RegExp(
                  r'(ลบ)|(ลด)|((?=[\D]|)(\-)(?=[^\d]))|(^-)|(?<=\d)(\-)(?=\d)'),
              '|');
          text = text.replaceAll(RegExp(r'(ฮ่าง)|(ห้า)'), "5");
          text = text.replaceAll(RegExp(r'(เปิดเน็ต)|(เปอร์เซ็นต์)'), '%');
          text = text.replaceAll(RegExp(r'(%ของ)|(% ของ)'), '!');
          text = text.replaceAll(RegExp(r'(ส่วน)'), '#');
          // text = text.replaceAll(RegExp(r'(ของ)'), '@');
          text = text.replaceAll(RegExp(r'[^\d|+\-*/%().@#!]'), '');

          // final splitted = text.split(RegExp(r'(ทั้งหมด)|(ถังหมด)'));
          final splittall = text.split(RegExp(r'[\#\+\-\*/\@]'));
          final splittr = text.split(RegExp(r'(?=[+|*/@#!])|(?<=[+|*/@#!])'));
          complete_exp = true;
          var sta = 0;
          var po = "";
          if (splittr.first.contains(RegExp(r'[+/*|]'))) {
            print(answer);
            if (answer.contains((RegExp(r'[\d\.]')))) {
              // print(splittr);
              splittr.insert(0, answer);
            } else {
              splittr.removeAt(0);
            }
          }
          // while(splittr.length > 1){

          var i = 0;
          print(splittr.first.isEmpty);
          if (splittr.length == 2 ||
              (splittr.length == 1 && splittr.first.isEmpty)) {
            complete_exp = false;
          }
          while (complete_exp && splittr.length > 2) {
            // set state 0 is #@! 1 is left to right 2 is operand
            if (sta == 0) {
              i = splittr
                  .indexWhere((element) => element.contains(RegExp(r'^[#!]')));
              if (i == -1) {
                i = 0;
                sta += 1;
                print("DEP >> OUT TO 1");
              } else {
                var operator = '';
                if (splittr[i - 1].contains(RegExp(r'^[#!+|/*]')) ||
                    splittr[i + 1].contains(RegExp(r'^[#!+|/*]'))) {
                  complete_exp = false;
                  operator = 'N/A';
                  print("DEP >> OUT FORMAT");
                } else if (splittr[i].contains(RegExp(r'^[#]'))) {
                  operator = '/';
                } else {
                  operator = '/100*';
                }
                splittr.insert(
                    i - 1,
                    "(" +
                        splittr[i - 1].toString() +
                        operator +
                        splittr[i + 1].toString() +
                        ")");
                splittr.removeRange(i, i + 3);
              }
            } else if (sta == 1) {
              i = splittr.indexWhere(
                  (element) => element.contains(RegExp(r'^[+/*|]')));
              if (i == -1) {
                sta += 1;
                print("DEP >> OUT TO OUTSCOPE");
              } else {
                if (splittr[i - 1].contains(RegExp(r'^[#!+|/*]')) ||
                    splittr[i + 1].contains(RegExp(r'^[#!+|/*]'))) {
                  complete_exp = false;
                  print("DEP >> OUT FORMAT");
                } else {
                  splittr.insert(
                      i - 1,
                      "(" +
                          splittr.sublist(i - 1, i + 2).join('').toString() +
                          ")");
                  splittr.removeRange(i, i + 3);
                }
              }
            } else {
              complete_exp = false;
              print("DEP >> OUT QU");
            }

            print(i);
            print(splittr);
          }
          print("DEP >> OUT LOOp");
          if (complete_exp) {
            responseText = splittr.first;
            responseText = responseText.replaceAll("|", "-");
          } else {
            responseText = answer;
          }
          // print("FINAL" + responseText);
          recognizeFinished = true;
        });
      } else {
        setState(() {
          text = currentText;
          recognizeFinished = true;
          if (text.contains('หยุด')) {
            voicecontrolstop = true;
            recognizing = false;
          }
        });
        // print("NOTFinal : " + text);
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F4F8),
        body: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 60, 20, 30),
                            alignment: Alignment.centerRight,
                            child: Text(
                              responseText.toString(),
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFF57636C)),
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
                              onLongPress: () {
                                setState(() {
                                  responseText = '0';
                                  answer = '0';
                                });
                              },
                            ))),
                  )),
            ],
          );
        }));
  }

  void equalPressed() {
    String finaluserinput(String str) {
      str = str.replaceAll('x', '*');
      str = str.replaceAll('%', '/100');
      return str;
    }

    String input = responseText;
    print(input);
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput(input));

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toStringAsFixed(4);

    if (complete_exp) {
      if (eval % 1 == 0) {
        synthesizeText(voiceSense(responseText, eval.toString()), 'A');
      } else {
        synthesizeText(voiceSense(responseText, eval.toString()), 'B');
      }
    } else {
      synthesizeText(
          "สมการผิดพลาดกรุณาลองใหม่อีกครั้งค่ะ ค่าที่เก็บไว้ก่อนหน้านี้คือ" +
              answer,
          'C');
    }
  }

  String voiceSense(String inputs, String outputs) {
    inputs = inputs.replaceAll(')', '');
    inputs = inputs.replaceAll('/', 'หาร');
    inputs = inputs.replaceAll('*', 'คูณ');
    inputs = inputs.replaceAll('+', 'บวก');
    inputs = inputs.replaceAll('-', 'ลบ');
    // print(inputs);
    return inputs + 'คำตอบคือ ' + outputs;
  }
}
