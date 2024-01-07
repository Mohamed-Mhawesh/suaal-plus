import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/view/Components/country_picker.dart';
import '../../controllers/signup_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../../theme/constants.dart';
import '../../helpers/valid_input.dart';
import '../Components/already_have_an_account_check.dart';
import '../Components/elevated_btn.dart';
import '../Components/my_choice_chip.dart';
import '../Components/rounded_input_field.dart';
import '../Components/simple_shadow.dart';
import '../Login/login_screen.dart';

class SignUpScreen2 extends StatelessWidget {
  SignUpScreen2({Key? key}) : super(key: key);
  SignupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          width: double.infinity,
          height: size.height,
          child: SingleChildScrollView(
            controller: controller.signUpScrollController,
            child: GetBuilder<SignupController>(
              builder: (controller) => Form(
                key: controller.formState2,
                autovalidateMode: controller.autoValidateMode2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: size.width * 0.5,
                        height: size.height * 0.3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            ''' "رائع" ''',
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          )),
                          Text(
                            'نحتاج الآن لبعض المعلومات التي ستجعل تجربتك مميزة وفريدة.',
                            style: w600TextStyle,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          "- اختر الصورة الرمزية التي ستظهر بها في التطبيق",
                          style: normalTextStyle),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                spreadRadius: 0,
                                offset: Offset(0, 4)),
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                spreadRadius: 0,
                                offset: Offset(2, 0)),
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      height: size.height * 0.12,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.008),
                          itemCount: controller.avatars.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                controller.chooseAvatar(
                                    controller.avatars[index].name);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.chosenAvatar ==
                                            controller.avatars[index].name
                                        ? kLightColor.withOpacity(0.2)
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: controller.chosenAvatar ==
                                                controller.avatars[index].name
                                            ? kPrimaryColor
                                            : Colors.transparent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.network(
                                      "https://suaalplus.sy/public/img/${controller.avatars[index].name}"),
                                ),
                              ),
                            );
                          }),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "- أدخل معلوماتك الحقيقية من فضلك",
                        style: normalTextStyle,
                      ),
                    ),
                    RoundedInputField(
                      valid: (val) {
                        return validInput(val!, 2, 20, "username");
                      },
                      controller: controller.firstname,
                      hintText: "الاسم الأول",
                      icon: Icons.person,
                      onChanged: (value) {},
                      kbType: TextInputType.name,
                    ),
                    RoundedInputField(
                      valid: (val) {
                        return validInput(val!, 2, 20, "username");
                      },
                      controller: controller.lastname,
                      hintText: "الاسم الأخير",
                      icon: Icons.person,
                      onChanged: (value) {},
                      kbType: TextInputType.name,
                    ),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "- أنت...",
                        style: normalTextStyle,
                      ),
                    ),
                    Row(
                      children: [
                        MyChoiceChip(
                          process: "gr",
                          chipText: "     طالب     ",
                          chipId: 0,
                        ),
                        MyChoiceChip(
                          process: "gr",
                          chipText: "    متخرج    ",
                          chipId: 1,
                        ),
                      ],
                    ),

                    CountryPicker(
                        countryName: controller.chosenPCountry,
                        onCountryChanged: (c) {
                          controller.chosenPCountry = c;
                        }),
                    SizedBox(
                      height: size.height * 0.008,
                    ),
                    Visibility(
                      visible: controller.chosenPCountry == "🇸🇾    Syria"
                          ? true
                          : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                                Text("- تُقيم في...", style: normalTextStyle),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     دمشق     ",
                                  chipId: 1,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     ريف دمشق     ",
                                  chipId: 2,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     حلب     ",
                                  chipId: 3,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     حمص     ",
                                  chipId: 4,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     حماة     ",
                                  chipId: 5,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     اللاذقية     ",
                                  chipId: 6,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     إدلب     ",
                                  chipId: 7,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     الحسكة     ",
                                  chipId: 8,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     دير الزور     ",
                                  chipId: 9,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     طرطوس     ",
                                  chipId: 10,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     الرقة     ",
                                  chipId: 11,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     درعا     ",
                                  chipId: 12,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     السويداء     ",
                                  chipId: 13,
                                ),
                                MyChoiceChip(
                                  process: "ci",
                                  chipText: "     القنيطرة     ",
                                  chipId: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text("- المحافظة"),
                    // ),

                    Visibility(
                      visible: controller.graduated == 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("- ما هو نوع تعليمك؟",
                                style: normalTextStyle),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                MyChoiceChip(
                                  process: "le",
                                  chipText: "     عام     ",
                                  chipId: 1,
                                ),
                                MyChoiceChip(
                                  process: "le",
                                  chipText: "     خاص     ",
                                  chipId: 2,
                                ),
                                MyChoiceChip(
                                  process: "le",
                                  chipText: "     افتراضي     ",
                                  chipId: 3,
                                ),
                                MyChoiceChip(
                                  process: "le",
                                  chipText: "     مفتوح     ",
                                  chipId: 4,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text("- ما هي جامعتك؟", style: normalTextStyle),
                          ),
                          SizedBox(
                            height: size.height * 0.08,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.activeUniversity.length,
                                itemBuilder: (context, index) {
                                  return MyChoiceChip(
                                    process: "un",
                                    chipText:
                                        "   ${controller.activeUniversity[index].name}   ",
                                    chipId:
                                        controller.activeUniversity[index].id,
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("- أنت الآن في السنة...",
                                style: normalTextStyle),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                MyChoiceChip(
                                  process: "st",
                                  chipText: "      الأولى      ",
                                  chipId: 1,
                                ),
                                MyChoiceChip(
                                  process: "st",
                                  chipText: "     الثانية    ",
                                  chipId: 2,
                                ),
                                MyChoiceChip(
                                  process: "st",
                                  chipText: "     الثالثة     ",
                                  chipId: 3,
                                ),
                                MyChoiceChip(
                                  process: "st",
                                  chipText: "     الرابعة     ",
                                  chipId: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: controller.isLoading,
                        child: Center(
                          child: SizedBox(
                              width: size.width * 0.2,
                              child:
                                  Lottie.asset("assets/images/loading0.json")),
                        )),

                    Center(
                      child: ElevatedBtn(
                        text: "إنشاء حساب جديد",
                        fontSize: 16.sp,
                        press: () async {
                          if (await ConnectivityCheck.checkConnect() == false) {
                            controller.noInternet(context, size);
                          } else {
                            controller.doSignup();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Get.offAll(LoginScreen());
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    Center(
                        child:
                            privacyPolicyLinkAndTermsOfService(size, context)),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage(Size size, String image, int index) => SimpleShadow(
        color: kPrimaryColor,
        offset: const Offset(5, 5),
        child: Container(
          height: size.height * 0.21,
          width: size.width * 0.3,
          margin: EdgeInsets.symmetric(
            vertical: size.height * 0.03,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              )),
        ),
      );

  Widget privacyPolicyLinkAndTermsOfService(Size size, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
      child: Center(
          child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                  text: 'عن طريق المتابعة، أنت توافق على  ',
                  style: normalTextStyle,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'شروط الاستخدام',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                                "شروط استخدام تطبيق Suaal Plus",
                                                style:
                                                    TextStyle(fontSize: 14.sp)),
                                            Text(
                                                '''الرجاء قراءة اتفاقيتنا بعناية قبل قبول شروطها، حيث أنها توضح مسؤولياتك كمستخدم للتطبيق كما تحدد من مسؤوليتنا الخاصة. بدخولك إلى هذا التطبيق و استخدام المعلومات المتوفرة فيه، فإنك توافق على ما جاء في سياسة الخصوصية هذه وتقبل الإلتزام والتقيّد ببنودها. وإن محتويات هذا التطبيق عرضة للتغيير من دون إشعار مسبق، وإذا لم تكن موافقاً على أي من بنود هذه الاتفاقية، الرجاء عدم الدخول واستخدام أو تنزيل أي مواد من هذا التطبيق. 
إن جميع النصوص والرسومات والعلامات التجارية وتصميم التطبيق، إضافة إلى جميع المحتويات الأخرى المعروضة في هذا التطبيق  هي ملك حصري فقط لـ ملاك "سؤال بلس" ،كما أن جميع خدماته وبرامجه تملك  الحقوق كاملة على جميع الملكيات الفكرية لهذا التطبيق وخدماته بما فيها العلامات التجارية الخاصة به،  إضافة إلى الشعارات، والتصميم، والنصوص، والرسومات الخ. وبالتالي، لا يجوز استخدام أي من محتويات هذا التطبيق بأي طريقة كانت لأغراض تجارية من دون أخذ إذن خطي مسبق منا. ولا يجوز لك بيع أو توزيع أي أعمال أو محتويات مشتقة من أي من المواد المنشورة في هذا التطبيق لمكاسب تجارية، ولا يجوز لك تعديل أو تضمين هذه الأعمال في أي عمل آخر أو في مطبوعة تجارية أو موقع أو غير ذلك بأي طريقة أو بأي شكل كان بما في ذلك النسخ أو بالوسائل الإلكترونية أو من خلال نشر نفس المحتوى على تطبيق آخر من دون موافقة خطية مسبقة من "سؤال بلس"
''',
                                                style:
                                                    TextStyle(fontSize: 14.sp)),
                                            SizedBox(
                                                width: size.width * 0.5,
                                                child: ElevatedBtn(
                                                    text: "تم",
                                                    fontSize: 16.sp,
                                                    press: () {
                                                      Get.back();
                                                    }))
                                          ],
                                        ),
                                      ),
                                    ));
                          }),
                    TextSpan(
                        text: ' و ',
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'سياسة الخصوصية',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: kPrimaryColor,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      "سياسة خصوصية تطبيق Suaal Plus",
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                  Text(
                                                      '''نظرًا للطبيعة التي يتسم فيها تطبيقنا، فإن التطبيق يعتمد إلى معالجة البيانات الشخصية وتخزينها من أجل تحقيق الفائدة من التطبيق  ونحن ملتزمون بسؤالك ما إذا كنت توافق على هذا الأمر من عدمه. إذا لم تكن لديك رغبة في هذا، فإننا بكل أسف لن نكون قادرين على معالجة أي طلب تقدمه من خلال التطبيق هذا. أما في حال موافقتك، يمكنك اختيار أحد أمرين إما أن نستخدم بياناتك فقط لغرض معالجة الطلب الذي قدمته، أو أنه يمكن لسؤال بلس استخدام البيانات في أغراض أخرى لمزيد من الاتصالات (ويخضع هذا دائمًا إلى سياسة الخصوصية الواردة أدناه (

سياسة الخصوصية

يكن سؤال بلس احترام لخصوصية كل فرد يزوره ، وستستخدم أية معلومات تُجمع عنك في المقام الأول بغرض تنفيذ أي خدمة قد تطلبها، وفي المقام الثاني من أجل تحسين الآلية التي نتبعها كتطبيق في تقديم خدماتنا إليك. ونحن نفعل ذلك من خلال استخدام المعلومات بصورة ملائمة.

لن يتم الكشف عن هذه المعلومات إلى أي شخص خارج تطبيق سؤال بلس أو التطبيقات التابعة أو الشريكة لها والوكلاء والمكاتب التجارية والجهات المرخص لها من أي من هذه الشركات،  في الترتيب بصورة مباشرة أو غير مباشرة لخدمات تعود بالنفع عليك. وسيتم التعامل مع هذه المعلومات وفقًا للأحكام القانونية ذات الصلة المتعلقة بحماية البيانات، ويجوز تخزينها ومعالجتها مبدئيًا داخل  بأي مكان في العالم. ولن تُستخدم هذه المعلومات إلا لأغراض تتعلق بالاستفادة من خدمة سؤال بلس الأساسية .

ويحق لك بصفتك فردًا معرفة المعلومات التي نحتفظ بها عنك وتصحيحها إذا لزم الأمر؛ كما يحق لك أن تطلب منا عدم استخدام المعلومات. سنبذل قصارى جهدنا من أجل مراعاة رغباتك. لكن هناك تشريعات معينة يجوز لها أن تمنع ذلك، لا سيما تلك المتعلقة بمسائل السلامة .

لقد بذلنا الغالي والنفيس لضمان صحة المعلومات والتفاصيل الواردة  في وقت آخر تحديث لها. 


الأسئلة المتكررة

1. ما هي الفوائد التي سأحصل عليها عندما تجمع سؤال بلس معلوماتي؟
2. ما هي المعلومات التي قد يجمعها سؤال بلس؟
3. كيف ستجمع سؤال بلس هذه المعلومات وتخزنها؟
4. إلى متى ستخزين سؤال بلس هذه المعلومات؟
5. أين ستُخزن معلوماتك الشخصية ؟
6. لماذا تجمع سؤال بلس هذه المعلومات؟
7. على من تُطبق هذه السياسة؟
8. التزام سؤال بلس تجاه خصوصية الأطفال.
9. ما هي ملفات تعريف الارتباط؟
10. ما هي الملفات التعريفية للعملاء؟
11. كيف أصحح المعلومات المتعلقة بي؟
12. ما هي الخيارات المتوفرة لدي إذا اخترت التسجيل؟
13. ماذا يحدث إذا اخترت عدم التسجيل؟

ما هي الفوائد التي سأحصل عليها عندما تجمع سؤال بلس معلوماتي؟

جمع هذه المعلومات سيساعد سؤال بلس على تحقيق ما يلي؛
1. يسهل استخدام التطبيق بالنسبة لك من خلال عدم الحاجة إلى إدخال المعلومات أكثر من مرة واحدة.
2. يساعدنا على تقديم المعلومات بصورة أسرع..
4. يساعدك في العثور على الخدمات والمعلومات المتوفرة من سؤال بلس بسرعة.
5. استخدام المعلومات لإجراء تحسينات على التطبيق.

ما هي المعلومات التي قد يجمعها سؤال بلس؟
نعتزم في سؤال بلس منحك أكبر قدرٍ ممكن من التحكم في معلوماتك الشخصية.  نحتاج إلى معلومات منك مثل اسمك وبلد إقامتك , نوع التعليم , والجامعة وغيره من المعلومات التي تؤمن لك الخيارات الأفضل لاستخدام التطبيق.

إذا اخترت إفادة سؤال بلس بمعلوماتك الشخصية التي قد نحتاجها عبر  لمراسلتك أو تقديم اشتراك لك مثلاً - فإننا نوي إحاطتك علمًا بكيفية استخدامنا لمثل هذه المعلومات. وإذا أخبرتنا بأنك لا ترغب في استخدام هذه المعلومات كأساس لإجراء مزيد من الاتصالات معك، فإننا سنحترم رغباتك  , لكن ستفقد خيارات مناسبة 


كيف ستجمع سؤال بلس هذه المعلومات وتخزنها؟
يستطيع الموقع جمع المعلومات عنك بعدة طرق؛ إما بطلبها مباشرة منك (في نموذج تسجيل مثلاً) أو من خلال التسجيل التلقائي لمعلومات عن زيارتك لهذا الموقع. على سبيل المثال، قد نجمع معلومات عن رحلتك في الموقع أو نسجل الخيارات التي فضلتها.

تُخزين المعلومات في بيئة آمنة تتمتع بالحماية بفضل مجموعة من الإجراءات المادية والفنية. حيث لا يُسمح بالوصول العام إلى هذه المعلومات.

إلى متى ستخزن سؤال بلس هذه المعلومات؟
ستخزن سؤال بلس هذه المعلومات في بيئة آمنة تتمتع بالحماية طوال أي مدة نعتقد أن هذه المعلومات ستكون خلالها مصدر عون لنا في فهم كيفية تقديم خدماتنا إليك واحترام رغباتك. إضافة إلى ذلك، قد تلزمنا التشريعات بتخزين هذه المعلومات لفترة زمنية محددة. لفهم كيفية تعديل المعلومات المخزنة عنك أو تحديثها، يُرجى الرجوع إلى السؤال الملائم في هذا القسم.

أين ستُخزن معلوماتك الشخصية؟
تمارس سؤال بلس أنشطتها في عدة دول من جميع أنحاء العالم. حتى نتمكن من أن نقدم خدمة متناسقة لك ولعملائنا حيثما تكون، وهذا التطبيق موجود حاليًا في الجمهورية العربية السورية .

لماذا تجمع سؤال بلس هذه المعلومات؟
نحتاج إلى هذه المعلومات لمساعدتنا على تحسين خدماتنا المقدمة إليك؛ كما نريد تسهيل تهيئة منتجاتنا وخدماتنا بحيث تلائم احتياجاتك الخاصة.

على من تُطبق هذه السياسة؟
تُطبق هذه السياسة العملاء من الأفراد المستخدمين لتطبيق

التزام سؤال بلس تجاه خصوصية الأطفال
تعد حماية خصوصية الأطفال على قدرٍ كبير من الأهمية. ولهذا السبب لا نعمد مطلقًا إلى جمع أو تخزين أية معلومات على موقع الويب الخاص بنا من هؤلاء الذين نعلم يقينًا أن أعمارهم أقل من 16 عام.


كيف أصحح المعلومات المتعلقة بي؟
يتيح لك إمكانية مراجعة المعلومات الشخصية التي قدمتها وتحديثها. وفي أماكن أخرى، تتمتع بخيار إلغاء عضويتك في الخدمة. وفي أحيان أخرى، عندما تكون بحاجة إلى تصحيح المعلومات الشخصية التي قدمتها إلى سؤال بلس في وقت سابق، يُرجى إتباع التعليمات الواردة.

ماذا بشأن أمان الإنترنت ؟
الإنترنت ليس نظامًا آمنًا ولذلك يتعين عليك دومًا توخي الحذر فيما يتعلق بالمعلومات التي تكشف عنها عندما تكون على شبكة الإنترنت. يتم تخزين المعلومات الشخصية من قبل سؤال بلس في بيئات تشغيل آمنة غير متاحة للعامة. وفي بعض الحالات، يتم تشفير المعلومات الشخصية قبل إجراء معاملتك باستخدام تقنية آمنة ملائمة.


''',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                  SizedBox(
                                                      width: size.width * 0.5,
                                                      child: ElevatedBtn(
                                                          text: "تم",
                                                          fontSize: 16.sp,
                                                          press: () {
                                                            Get.back();
                                                          }))
                                                ],
                                              ),
                                            ),
                                          ));
                                  // code to open / launch privacy policy link here
                                })
                        ])
                  ]))),
    );
  }
}
