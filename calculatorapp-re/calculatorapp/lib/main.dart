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
import 'package:calculatorapp/TextToSpeechAPI.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;
  AudioPlayer audioPlugin = AudioPlayer();

  void synthesizeText(String text, String name) async {
    if (audioPlugin.state == PlayerState.playing) {
      await audioPlugin.stop();
    }
    // Hard coding the voice related settings
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
      print(data.results);
      if (data.results.first.isFinal) {
        text = '' + currentText;
        print("isFinal : " + text);
        setState(() {
          // print("isFinal text : " + text);
          print(text);
          text = text.replaceAll(
              RegExp(r'(บวกลบ)|(บวก\D*ลบ)|(\+\-) |(\+ \-)'), '-');
          text = text.replaceAll(
              RegExp(r'(ลบบวก)|(ลบ\D*บวก)|(\-\+) |(\- \+)'), '-');
          text = text.replaceAll(RegExp(r'(หาร)|([/])'), ')/');
          text = text.replaceAll(RegExp(r'(คูณ)|([\*])'), ')*');
          text = text.replaceAll(RegExp(r'(บวก)|([\+])'), ')+');
          text = text.replaceAll(RegExp(r'(ลบ)|([\-])'), ')-');
          text = text.replaceAll(RegExp(r'(เปิดเน็ต)|(เปอร์เซ็นต์)'), '%');
          text = text.replaceAll(RegExp(r'(%ของ)|(% ของ)'), '%)*');
          final splitted = text.split(RegExp(r'(ทั้งหมด)|(ถังหมด)'));
          final splittall = text.split(RegExp(r'[\+\-\*/]'));
          String result = "";

          for (var i = 1; i < (splitted.length + splittall.length); i++) {
            result = result + "(";
          }
          if (splittall.first.contains(RegExp(r'[\d]'))) {
            responseText = '';
          } else {
            result += responseText;
          }

          result = result + splitted.map((val) => val.trim()).join(')');
          print(result);

          // result = result.replaceAll(new RegExp(r'%'), '/100');
          result = result.replaceAll(new RegExp(r'[^\d\+\-\*/\%().]'), '');

          int a = 0;
          // if
          // for (var i in splittall) {

          // }

          print(responseText);
          responseText = result + ')';
          recognizeFinished = true;
          // equalPressed();
        });
      } else {
        setState(() {
          text = currentText;
          recognizeFinished = true;
        });
        print("NOTFinal : " + text);
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
    // synthesizeText(text, '');
    // synthesizeText(input + 'เท่ากับ ', 'A');
    if (eval % 1 == 0) {
      // ftts.speak(eval.toStringAsFixed(0));

      synthesizeText(
          voiceSense(input + 'ดังนั้นจะ = ' + eval.toStringAsFixed(0)), 'A');
    } else {
      synthesizeText(voiceSense(input + 'ดังนั้นจะ = ' + eval.toString()), 'B');
      // ftts.speak(eval.toString());
    }
    //answer = exp.toString();
    //answer = eval.toString();
    //answer = j.toString();
    //toStringAsExponential(3);
  }

  String voiceSense(String inputs) {
    inputs = inputs.replaceAll(')', 'แล้ว');
    inputs = inputs.replaceAll('/', 'หารด้วย');
    inputs = inputs.replaceAll('*', 'คูณด้วย');
    inputs = inputs.replaceAll('+', 'บวกด้วย');
    inputs = inputs.replaceAll('-', 'ลบด้วย');
    print(inputs);
    return inputs;
  }
}
