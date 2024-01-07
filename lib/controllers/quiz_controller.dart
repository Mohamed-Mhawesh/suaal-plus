import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:suaal_plus/view/home/home_page.dart';
import '../helpers/connectivity_check.dart';
import '../theme/constants.dart';
import '../models/question_model.dart';
import '../models/university_model.dart';
import '../services/quiz_services.dart';
import '../view/Components/no_internet_dialog.dart';
import '../view/result/result_screen.dart';

class QuizController extends GetxController {
  final storage = const FlutterSecureStorage();
  String token = "";
  String userId = "";
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

  getIndvSubInfo() async {
    String? value = await storage.read(key: 'individuallySubId');
    String? value1 = await storage.read(key: 'individuallySubName');
    String? value2 = await storage.read(key: 'individuallySubYear');

    if (value != null) {
      subjectId = value;
    }
    if (value1 != null) {
      subjectName = value1;
    }
    if (value2 != null) {
      subjectYear = value2;
    }
    update();
  }

//تم نقل الكود الى ال ui
  // void endQuizBottomSheet(BuildContext context) {
  //   Get.bottomSheet(
  //     Container(
  //     decoration: const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius:  BorderRadius.only(
  //             topLeft: Radius.circular(25), topRight: Radius.circular(25))),
  //     height: 200,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         const Text(
  //           "هل تريد انهاء الامتحان؟",
  //           style: TextStyle(fontSize: 30),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(10),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               SizedBox(
  //                   height: 60,
  //                   width: 120,
  //                   child: ElevatedBtn(
  //                       text: "نعم",
  //                       press: () {
  //                         Get.back();
  //                         count();
  //                         timer!.cancel();
  //                         itemController = ItemScrollController();
  //                         // Get.toNamed(ResultScreen.routeName);
  //                         sendQuizResult();
  //                         getResultDialog(context);
  //                       },),),
  //               //Get.offAndToNamed(WrongScreen.routeName);} )),
  //               SizedBox(
  //                   height: 60,
  //                   width: 120,
  //                   child: ElevatedBtn(
  //                       text: "لا",
  //                       press: () {
  //                         Get.back();
  //                         itemController = ItemScrollController();
  //                       }))
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   ),
  //   );
  // }

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
                      noInternet(context, size);
                    } else {
                      Get.back();
                      count();
                      timer!.cancel();
                      itemController = ItemScrollController();
                      sendQuizResult();
                      getResultDialog(context);
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
                          noInternet(context, size);
                        } else {
                          Get.back();
                          count();
                          timer!.cancel();
                          itemController = ItemScrollController();
                          // Get.toNamed(ResultScreen.routeName);
                          sendQuizResult();
                          getResultDialog(context);
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

  void getResultDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            Text(
              'النتيجة',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '$_countOfCorrectAnswers /${questions.length}',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 64.h,
                  width: size.width * 0.4,
                  child: ElevatedBtn(
                    text: "العثرات",
                    fontSize: 16.sp,
                    press: () {
                      _isDone = true;
                      Get.to(WrongScreen());
                      itemController = ItemScrollController();
                    },
                  ),
                ),
                SizedBox(
                  height: 64.h,
                  width: size.width * 0.4,
                  child: ElevatedBtn(
                    fontSize: 16.sp,
                    color: Colors.redAccent.withOpacity(0.9),
                    text: "إنهاء",
                    press: () async {
                      if (await ConnectivityCheck.checkConnect() == false) {
                        noInternet(context, size);
                      } else {
                        Get.delete<QuizController>();

                        Get.offAll(() => HomePage());
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
        return Color(0xff29bf12);
      } else {
        if (usedQuestionsAnswers["$questionId"]![answerIndex]["is_correct"] ==
            1) {
          return Color(0xff29bf12);
        } else if (_questionsIsAnswered[questionId]!["index"] == answerIndex &&
            _questionsIsAnswered[questionId]!["is_correct"] != 1) {
          return Color(0xfff21b3f);
        }

        return Colors.white;
      }
    } else if (_isDone == false) {
      if (_questionsIsAnswered[questionId]!["index"] == answerIndex) {
        return kPrimaryColor;
      } else {
        return Colors.white;
      }
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
      if (_questionsIsAnswered[questionId]!["index"] == answerIndex) {
        return Colors.white;
      } else {
        return Colors.black;
      }
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
          return Color(0xff29bf12);
        } else {
          return Color(0xfff21b3f);
        }
      } else {
        return Color(0xfff21b3f);
      }
    } else if (_isDone == false) {
      if (_questionsIsAnswered[questionId]!["index"] != -1) {
        print(_questionsIsAnswered);
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

  void startTimer(BuildContext context, int? min) {
    duration = Duration(minutes: min!);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      const addSeconds = -1;

      secondsInt = duration.inSeconds + addSeconds;
      if (secondsInt < 0) {
        update();
        count();
        timer!.cancel();
        sendQuizResult();
        getResultDialog(context);
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
      var quizData = await QuizServices.quizResultRequest(
          token, correctQuestionsId, allQuestionsId, userId.toString());
    } catch (e) {
      print("send result error : $e");
    }
    update();
  }

  void choose(String process, int chipId) {
    if (process == "le") {
      switch (chipId) {
        case 5:
          {
            learningType = "الكل";
            chosenLearningType = 5;
            universityID = 0;
            activeUniversity.clear();
            yearTimeCanUsed.clear();
            numbersOfQuestionsCanUsed.clear();
            getQuizYears(universityID);
            getQuestionsNumber(
                subjectId, yearTimeDropdownValue, universityID, learningType);

            update();
          }
          break;
        case 1:
          {
            learningType = "عام";
            chosenLearningType = 1;
            universityID = 0;
            activeUniversity.clear();
            yearTimeCanUsed.clear();
            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            getQuizYears(universityID);
            getQuestionsNumber(
                subjectId, yearTimeDropdownValue, universityID, learningType);
            update();
          }
          break;
        case 2:
          {
            learningType = "خاص";
            universityID = 0;
            chosenLearningType = 2;
            activeUniversity.clear();
            yearTimeCanUsed.clear();
            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            getQuizYears(universityID);
            getQuestionsNumber(
                subjectId, yearTimeDropdownValue, universityID, learningType);
            update();
          }
          break;
        case 3:
          {
            learningType = "افتراضي";
            universityID = 0;
            chosenLearningType = 3;
            activeUniversity.clear();
            yearTimeCanUsed.clear();
            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            getQuizYears(universityID);
            getQuestionsNumber(
                subjectId, yearTimeDropdownValue, universityID, learningType);
            update();
            print(activeUniversity);
          }
          break;
        case 4:
          {
            learningType = "مفتوح";
            universityID = 0;
            chosenLearningType = 4;
            activeUniversity.clear();
            yearTimeCanUsed.clear();
            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            getQuizYears(universityID);
            getQuestionsNumber(
                subjectId, yearTimeDropdownValue, universityID, learningType);
            update();
            print(activeUniversity);
          }
          break;
        default:
          {
            learningType = "عام";
            universityID = 0;
            chosenLearningType = 1;
            activeUniversity.clear();
            yearTimeCanUsed.clear();
            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            getQuizYears(universityID);
            getQuestionsNumber(
                subjectId, yearTimeDropdownValue, universityID, learningType);
            update();
          }
      }
    }
    if (process == "un") {
      for (var i in activeUniversity) {
        if (i.id == chipId) {
          universityID = i.id;
          getQuizYears(universityID);
          getQuestionsNumber(
              subjectId, yearTimeDropdownValue, universityID, learningType);
          update();
        }
      }
    }
  }

  changeYearTime(String year) async {
    yearTimeDropdownValue = year;

    await getQuestionsNumber(subjectId, year, universityID, learningType);
    update();
  }

  changeQuestionsNum(String num) {
    questionsNumberDropdownValue = num;
    update();
  }

  getQuestionsNumber(subId, yearTime, universityId, learningType) async {
    isLoading = true;
    numbersOfQuestionsCanUsed.clear();
    print(subId);
    print(yearTime);
    print(universityId);
    print(learningType);
    print(subjectYear);

    try {
      var quizData = await QuizServices.getQuestionsNumber(token, subId,
          yearTime, universityId == 0 ? "الكل" : universityId, learningType);
      if (int.parse(quizData) <= 50) {
        numOfQuestions = int.parse(quizData);
      } else if (int.parse(quizData) > 50) {
        numOfQuestions = 50;
      }
      print(quizData);
      print("num of questions$numOfQuestions");
      for (var i = 0; i <= numOfQuestions; i = i + 10) {
        if (i != 0) {
          numbersOfQuestionsCanUsed.add("$i");
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }

    update();
  }

  getQuizUniversities() async {
    isLoading = true;
    update();
    try {
      var universityData = await QuizServices.quizUniversityRequest(token);
      for (Map<String, dynamic> i in universityData) {
        university.add(University.fromJson(i));
      }
      activeUniversity.clear();
      activeUniversity
          .add(University(id: 0, name: "الكل", learningType: "الكل"));
      activeUniversity.addAll(
          university.where((element) => element.learningType == learningType));
      update();
    } finally {
      isLoading = false;
      update();
    }

    update();
  }

  getQuizYears(universityId) async {
    isLoading = true;
    update();
    try {
      var yearsData = await QuizServices.quizYearsRequest(token,
          universityId == 0 ? "الكل" : universityId, learningType, subjectId);
      yearTimeCanUsed.clear();
      yearTimeCanUsed.add("الكل");
      for (String i in yearsData) {
        yearTimeCanUsed.add(i);
      }
      print(yearTimeCanUsed);
      update();
    } finally {
      isLoading = false;
      update();
    }

    update();
  }

  getQuizData(subId, BuildContext context) async {
    isLoading = true;
    update();
    try {
      var quizData = await QuizServices.individuallyRequest(
          token,
          subId,
          int.parse(questionsNumberDropdownValue),
          learningType,
          universityID == 0 ? "الكل" : universityID,
          yearTimeDropdownValue);

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
      startTimer(context, questions.length);
      _isDone = false;
    } catch (e) {
      print(e);
    } finally {
      checkInternet();
      isLoading = false;
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

  void noInternet(BuildContext context, Size size) {
    showNoInternetDialog(context, size);
  }

  Future<dynamic> showNoInternetDialog(BuildContext context, Size size) {
    return showDialog(
        context: context, builder: (context) => const NoInternetDialog());
  }

  @override
  void onInit() async {
    startAgain();
    await getUserToken();
    await getIndvSubInfo();
    await getQuizUniversities();
    await getQuizYears(universityID);
    await getQuestionsNumber(
        subjectId, yearTimeDropdownValue, universityID, learningType);

    super.onInit();
  }
}
