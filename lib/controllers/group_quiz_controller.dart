import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:suaal_plus/services/group_services.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:suaal_plus/view/home/home_page.dart';
import 'package:suaal_plus/view/result/group_wrong_screen.dart';
import 'package:worldtime/worldtime.dart';
import '../helpers/connectivity_check.dart';
import '../theme/constants.dart';
import '../models/question_model.dart';
import '../models/university_model.dart';

class GroupQuizController extends GetxController {
  final storage = const FlutterSecureStorage();
  String token = "";
  String userId = "";
  String roundId = "";
  String groupName = "";
  bool isLoading = false;
  bool isConnected = false;
  ItemScrollController itemController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  bool _isPressed = false;
  bool _isDone = false;

  bool get isPressed => _isPressed; //To check if the answer is pressed
  int? _selectAnswer;

  int? get selectAnswer => _selectAnswer;

  int _countOfWrongAnswer = 0;

  int get countOfWrongAnswer => _countOfWrongAnswer;

  int _countOfCorrectAnswers = 0;

  int get countOfCorrectAnswers => _countOfCorrectAnswers;
  final _questionsIsAnswered = <int, Map>{};
  String subjectId = "";
  String subjectName = "";
  String subjectYear = "";
  int index = 0;
  String timeZone = "";
  Timer? timer;
  Duration duration = const Duration();
  int secondsInt = 0;
  int minutesInt = 0;
  String minutes = "0";
  String seconds = "0";

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  List<QuestionsModel> questions = [];
  String correctQuestionsId = "";
  String allQuestionsId = "";
  Map<String, List<dynamic>> questionsAnswers = {};
  Map<String, List<dynamic>> usedQuestionsAnswers = {};
  String learningType = "الكل";
  int universityID = 0;
  int studyYear = 1;
  int chosenLearningType = 5;
  int numOfQuestions = 0;
  List numbersOfQuestionsCanUsed = [];
  String questionsNumberDropdownValue = "10";
  List<University> university = [];
  List<University> activeUniversity = [];

  List yearTimeCanUsed = [];
  String yearTimeDropdownValue = "الكل";

  DateTime worldDateTime = DateTime.now();

//fun to scroll up/down to question by index
  Future scrollToQuestion(index) async {
    itemController.scrollTo(
        index: index, alignment: 0, duration: const Duration(seconds: 1));
  }

  getUserToken() async {
    String? tokenValue = (await storage.read(key: 'token'));
    String? userIdValue = (await storage.read(key: 'userId'));
    if (tokenValue != null) {
      token = tokenValue;
      userId = userIdValue!;
    }
    update();
  }

  getGroupDetails() async {
    String? roundIdValue = (await storage.read(key: 'round_id'));
    String? groupNameValue = (await storage.read(key: 'group_name'));

    roundId = roundIdValue!;
    groupName = groupNameValue!;

    update();
  }

  resetQuizDetails() {
    allQuestionsId = "";
    correctQuestionsId = "";
    _countOfCorrectAnswers = 0;
    _countOfWrongAnswer = 0;
    _isDone = false;
  }

  count() {
    resetQuizDetails();
    for (int i = 0; i < _questionsIsAnswered.length; i++) {
      allQuestionsId = "$allQuestionsId${questions[i].id},";
      if (_questionsIsAnswered[questions[i].id]!["is_correct"] == 1) {
        correctQuestionsId = "$correctQuestionsId${questions[i].id},";
        _countOfCorrectAnswers++;
      } else {
        _countOfWrongAnswer++;
      }
    }
  }

  void getDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (index == 0) {
      count();

      index = 1;
      Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 16.sp),
        buttonColor: kPrimaryColor,
        cancelTextColor: kPrimaryColor,
        confirmTextColor: Colors.white,
        backgroundColor: Colors.white,
        radius: 30,
        title: 'تحقق من اجاباتك',
        content: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'عدد اجاباتك الصحيحة $_countOfCorrectAnswers',
                style: TextStyle(fontSize: 16.sp),
              ),
              Text(
                'عدد اجاباتك الخاطئة $_countOfWrongAnswer',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                height: 64.h,
                width: size.width * 0.3,
                child: ElevatedBtn(
                  text: "تصحيح",
                  fontSize: 14.sp,
                  press: () {
                    Get.back();
                    itemController = ItemScrollController();
                    resetQuizDetails();
                  },
                ),
              ),
              SizedBox(
                height: 64.h,
                width: size.width * 0.3,
                child: ElevatedBtn(
                  color: Colors.redAccent.withOpacity(0.9),
                  text: "إنهاء",
                  fontSize: 14.sp,
                  press: () async {
                    if (await ConnectivityCheck.checkConnect() == false) {
                      // noInternet(context, size);
                    } else {
                      Get.back();
                      count();
                      timer!.cancel();
                      itemController = ItemScrollController();
                      // Get.toNamed(ResultScreen.routeName);
                      sendQuizResult();
                      getResultDialog();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      Get.defaultDialog(
        buttonColor: kPrimaryColor,
        cancelTextColor: kPrimaryColor,
        confirmTextColor: Colors.white,
        content: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 64.h,
                    width: size.width * 0.3,
                    child: ElevatedBtn(
                      text: "حسنًا",
                      fontSize: 14.sp,
                      press: () {
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  SizedBox(
                    height: 64.h,
                    width: size.width * 0.3,
                    child: ElevatedBtn(
                      color: Colors.redAccent.withOpacity(0.9),
                      text: "إنهاء",
                      fontSize: 14.sp,
                      press: () async {
                        if (await ConnectivityCheck.checkConnect() == false) {
                          // noInternet(context, size);
                        } else {
                          Get.back();
                          count();
                          timer!.cancel();
                          itemController = ItemScrollController();
                          // Get.toNamed(ResultScreen.routeName);
                          sendQuizResult();
                          getResultDialog();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        radius: 30,
        titleStyle: TextStyle(fontSize: 16.sp),
        title: 'يمكنك التحقق لمرة واحدة فقط',
      );
    }
  }

  void getResultDialog() {
    // Size size = MediaQuery.of(context).size;
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: Colors.white,
      radius: 30,
      title: '',
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
      content: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          children: [
            // Text('عدد اجاباتك الصحيحة $_countOfCorrectAnswers'),
            // Text('عدد اجاباتك الخاطئة $_countOfWrongAnswer'),
            Text(
              'النتيجة',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),

            Text(
              '$_countOfCorrectAnswers /${questions.length}',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
                _countOfCorrectAnswers == 0
                    ? "للأسف لم تحصل على أي نقطة"
                    : getResultText(_countOfCorrectAnswers),
                style: TextStyle(
                  fontSize: 16.sp,
                )),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8, left: 8),
                  width: 16,
                  child: Image.asset("assets/icons/notification.png"),
                ),
                Text(
                  "شاهد نتائج المجموعة في قائمة الإشعارات",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 64.h,
                  //width: size.width * 0.4,
                  child: ElevatedBtn(
                    text: "العثرات",
                    fontSize: 16.sp,
                    press: () {
                      _isDone = true;
                      Get.to(GroupWrongScreen());
                      itemController = ItemScrollController();
                    },
                  ),
                ),
                SizedBox(
                  height: 64.h,
                  // width: size.width * 0.4,
                  child: ElevatedBtn(
                    fontSize: 16.sp,
                    color: Colors.redAccent.withOpacity(0.9),
                    text: "إنهاء",
                    press: () async {
                      if (await ConnectivityCheck.checkConnect() == false) {
                        //noInternet(context, size);
                      } else {
                        Get.delete<GroupQuizController>();

                        Get.offAll(() => const HomePage());
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getResultText(result) {
    if (result == 1) {
      return "تم إضافة نقطة إلى مجموع نقاطك";
    }
    if (result == 2) {
      return "تم إضافة نقطتين إلى مجموع نقاطك";
    }
    if (result > 2) {
      return "تم إضافة $result نقاط إلى مجموع نقاطك";
    }
  }

  //check if the question has been answered

  // checkIsQuestionAnswered(int quesId) {
  //   return _questionsIsAnswered.entries
  //       .firstWhere((element) => element.key == quesId)
  //       .value;
  // }

  void checkAnswer(QuestionsModel questionsModel, int selectAnswer) {
    _isPressed = true;
    _selectAnswer = selectAnswer;
    questionsModel.isAnswered = true;
    _questionsIsAnswered.addIf(questionsModel.isAnswered, questionsModel.id!, {
      "index": selectAnswer,
      "is_correct": usedQuestionsAnswers["${questionsModel.id}"]![selectAnswer]
          ["is_correct"] // 0|1
    });

    update();
  }

//-------------colors-----------------------------------------
  //get right and wrong color
  Color getColor(int answerIndex, int questionId) {
    if (_isDone == true) {
      if (_questionsIsAnswered[questionId]!["index"] == answerIndex &&
          _questionsIsAnswered[questionId]!["is_correct"] == 1) {
        return const Color(0xff29bf12);
        // return Colors.greenAccent[400]!.withOpacity(0.7);
      } else {
        if (usedQuestionsAnswers["$questionId"]![answerIndex]["is_correct"] ==
            1) {
          return const Color(0xff29bf12);
        } else if (_questionsIsAnswered[questionId]!["index"] == answerIndex &&
            _questionsIsAnswered[questionId]!["is_correct"] != 1) {
          return const Color(0xfff21b3f);
        }

        return Colors.white;
      }
    } else if (_isDone == false) {
      //if (isPressed) {
      if (_questionsIsAnswered[questionId]!["index"] == answerIndex) {
        return kPrimaryColor;
      } else {
        return Colors.white;
      }
      // }
      // return Colors.white;
    }
    return Colors.white;
  }

  Color getTextColor(int answerIndex, int questionId) {
    if (_isDone == true) {
      if (_questionsIsAnswered[questionId]!["index"] == answerIndex &&
          _questionsIsAnswered[questionId]!["is_correct"] == 1) {
        return Colors.white;
      } else {
        if (usedQuestionsAnswers["$questionId"]![answerIndex]["is_correct"] ==
            1) {
          return Colors.white;
        } else if (_questionsIsAnswered[questionId]!["index"] == answerIndex &&
            _questionsIsAnswered[questionId]!["is_correct"] != 1) {
          return Colors.white;
        }

        return Colors.black;
      }
    } else if (_isDone == false) {
      // if (isPressed) {
      if (_questionsIsAnswered[questionId]!["index"] == answerIndex) {
        return Colors.white;
      } else {
        return Colors.black;
      }
      // }
      // return Colors.black;
    }
    return Colors.black;
  }

  Color getColorForTextQuestion(int questionId) {
    if (isPressed) {
      if (_questionsIsAnswered[questionId]!["index"] != -1) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }

    return Colors.black;
  }

  Color getColorForQuestion(int questionId) {
    if (_isDone == true) {
      if (_questionsIsAnswered[questionId]!["index"] != -1) {
        if (_questionsIsAnswered[questionId]!["is_correct"] == 1) {
          return const Color(0xff29bf12);
        } else {
          return const Color(0xfff21b3f);
        }
      } else {
        return const Color(0xfff21b3f);
      }
    } else if (_isDone == false) {
      if (_questionsIsAnswered[questionId]!["index"] != -1) {
        return kPrimaryColor;
      } else {
        return Colors.white;
      }
    }
    return Colors.white;
  }

//------------------------------------------------------
  String getString(int index) {
    if (index == 0) {
      return "A";
    } else if (index == 1) {
      return "B";
    } else if (index == 2) {
      return "C";
    } else {
      return "D";
    }
  }

  startAgain() async {
    resetQuizDetails();
    questions.clear();
    questionsAnswers.clear();
    _selectAnswer = null;
  }

  //----------- timer ---------------------
  int sec = 1;

  getWorldTime() async {
    worldDateTime = await Worldtime().timeByCity(timeZone);
  }

  getTimeZone() async {
    try {
      var data = await GroupServices.getTimeZone();
      timeZone = data;
      update();
    } catch (e) {
      print(e);
    }
  }

  void startTimer() {
    duration = Duration(seconds: sec);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      const addSeconds = -1;

      secondsInt = duration.inSeconds + addSeconds;
      if (secondsInt < 0) {
        update();
        count();
        timer!.cancel();
        sendQuizResult();
        getResultDialog();
      } else {
        duration = Duration(seconds: secondsInt);
        seconds = twoDigits(duration.inSeconds.remainder(60));
        minutes = twoDigits(duration.inMinutes.remainder(60));
        update();
      }
    });
    update();
  }

  //------------------end timer ----------------------

//............................................................................

  sendQuizResult() async {
    try {
      var quizData = await GroupServices.sendGroupResult(token,
          correctQuestionsId, allQuestionsId, userId.toString(), roundId);
    } catch (e) {
      print("send result error : $e");
    }
    update();
  }

  getQuizData() async {
    isLoading = true;
    update();
    try {
      var quizData =
          await GroupServices.getQuestionsRequest(token, userId, roundId);
      DateTime endDate = DateTime.parse(quizData[2]);
      sec = endDate.difference(worldDateTime).inSeconds;
      update();

      for (Map<String, dynamic> question in quizData[0]) {
        questions.add(QuestionsModel.fromJson(question));
      }

      for (var k = 0; k < questions.length; k++) {
        questionsAnswers
            .addAll({"${questions[k].id}": quizData[1]["${questions[k].id}"]});
        usedQuestionsAnswers.addAll({"${questions[k].id}": []});
      }

      for (var k = 0; k < questions.length; k++) {
        int numOfAnswers;
        if (questionsAnswers["${questions[k].id}"]!.length == 2) {
          numOfAnswers = 1;
        } else if (questionsAnswers["${questions[k].id}"]!.length == 3) {
          numOfAnswers = 2;
        } else {
          numOfAnswers = 3;
        }

        if (questionsAnswers["${questions[k].id}"]!.isNotEmpty) {
          for (var i = 0; i < numOfAnswers; i++) {
            if (questionsAnswers["${questions[k].id}"]![i]["is_correct"] != 1) {
              usedQuestionsAnswers["${questions[k].id}"]!
                  .add(questionsAnswers["${questions[k].id}"]![i]);
            } else {
              numOfAnswers++;
            }
          }
        }
      }

      for (var k = 0; k < questions.length; k++) {
        var indexOfCorrectAnswers = 4;
        if (questionsAnswers["${questions[k].id}"]!.length == 2) {
          indexOfCorrectAnswers = Random().nextInt(2);
        } else if (questionsAnswers["${questions[k].id}"]!.length == 3) {
          indexOfCorrectAnswers = Random().nextInt(3);
        } else {
          indexOfCorrectAnswers = Random().nextInt(4);
        }
        if (questionsAnswers["${questions[k].id}"]!.isNotEmpty) {
          for (var i = 0;
              i < questionsAnswers["${questions[k].id}"]!.length;
              i++) {
            if (questionsAnswers["${questions[k].id}"]![i]["is_correct"] == 1) {
              usedQuestionsAnswers["${questions[k].id}"]!.insert(
                  indexOfCorrectAnswers,
                  questionsAnswers["${questions[k].id}"]![i]);
            }
          }
        }
      }

      for (var element in questions) {
        _questionsIsAnswered.addAll({
          element.id!: {"index": -1, "is_correct": 0}
        });

        element.selectedAnswer = -1;
        element.isAnswered = false;
      }

      _isDone = false;
    } catch (e) {
      print(e);
    } finally {
      checkInternet();
      isLoading = false;
      startTimer();
      update();
    }
    update();
  }

  checkInternet() async {
    if (await ConnectivityCheck.checkConnect() == true) {
      isConnected = true;

      update();
    } else {
      isConnected = false;
      update();
    }
  }

  @override
  void onInit() async {
    isLoading = true;
    update();
    checkInternet();
    startAgain();
    await getTimeZone();
    await getWorldTime();
    await getUserToken();
    await getGroupDetails();
    await getQuizData();

    super.onInit();
  }
}
