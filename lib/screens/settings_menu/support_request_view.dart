import 'package:get/get.dart';
import 'package:foap/helper/imports/common_import.dart';
import '../../model/support_request_response.dart';
import '../../universal_components/rounded_input_field.dart';

class SupportRequestView extends StatefulWidget {
  const SupportRequestView({Key? key}) : super(key: key);

  @override
  State<SupportRequestView> createState() => _SupportRequestViewState();
}

class _SupportRequestViewState extends State<SupportRequestView> {
  final item = Get.arguments as SupportRequest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          backNavigationBar(
               title: supportRequestsString.tr),
          divider().tP8,
          SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const BodyLargeText('Your Message', weight: FontWeight.bold),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  BodyLargeText(
                    item.requestMessage ?? '',
                    weight: TextWeight.regular,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  if (item.replyMessage != null)
                    const BodyLargeText(
                      'Admin Message',
                      weight: FontWeight.bold,
                    ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  BodyLargeText(
                    item.replyMessage ?? '',
                    weight: TextWeight.regular,
                  )
                ],
              ).extended,
            ),
          ).p25
        ],
      ),
    );
  }
}
