import 'package:foap/helper/imports/common_import.dart';
import 'package:get/get.dart';

import '../../controllers/faq_controller.dart';

class FaqList extends StatefulWidget {
  const FaqList({Key? key}) : super(key: key);

  @override
  State<FaqList> createState() => _FaqListState();
}

class _FaqListState extends State<FaqList> {
  // List<Map<String, String>> faqs = [
  //   {'question' :'1.Faq1', 'answer': 'Faq answer1'},
  //   {'question' :'2.Faq2', 'answer': 'Faq answer2'},
  //   {'question' :'3.Faq3', 'answer': 'Faq answer3'},
  //   {'question' :'4.Faq4', 'answer': 'Faq answer4'},
  //   {'question' :'5.Faq5', 'answer': 'Faq answer5'},
  // ];

  final FAQController _faqController = FAQController();

  @override
  void initState() {
    _faqController.loadFAQs();
    super.initState();
  }

  @override
  void dispose() {
    // _faqController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          backNavigationBar( title: faqString.tr),
          divider().tP8,
          Expanded(
              child: Obx(
            () => ListView.builder(
                padding: const EdgeInsets.only(bottom: 50),
                itemCount: _faqController.faqs.length,
                itemBuilder: (ctx, index) {
                  return ExpansionTile(
                    title: BodyLargeText(
                      _faqController.faqs[index].question,
                      weight: TextWeight.bold,
                    ),
                    children: <Widget>[
                      ListTile(
                          title: BodyLargeText(
                        _faqController.faqs[index].answer,
                      )),
                    ],
                    onExpansionChanged: (bool expanded) {},
                  );
                }),
          ))
        ],
      ),
    );
  }
}
