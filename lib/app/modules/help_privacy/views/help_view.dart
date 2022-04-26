import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providers/laravel_provider.dart';
import '../../global_widgets/tab_bar_widget.dart';
import '../controllers/help_controller.dart';
import '../widgets/faq_item_widget.dart';

class HelpView extends GetView<HelpController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var controller;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Get.theme.hintColor),
          bottom: controller.faqCategories.isEmpty
              ? TabBarLoadingWidget()
              : TabBarWidget(
                  tag: 'help',
                  initialSelectedId: controller.faqCategories.elementAt(0).id,
                  tabs: List.generate(controller.faqCategories.length, (index) {
                    var _category = controller.faqCategories.elementAt(index);
                    return ChipWidget(
                      tag: 'help',
                      text: _category.name.tr,
                      id: _category.id,
                      onSelected: (id) {
                        controller.getFaqs(categoryId: id);
                      },
                    );
                  }),
                ),
          title: Text(
            "Help & Faq".tr,
            style: Get.textTheme.headline6.merge(
                TextStyle(letterSpacing: 1.3, color: Get.theme.hintColor)),
          ),
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () => Get.back(),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            var forceRefresh = Get.find<LaravelApiClient>().forceRefresh();
            controller.refreshFaqs(
              showMessage: true,
              categoryId:
                  Get.find<TabBarController>(tag: '/help').selectedId.value,
            );
            Get.find<LaravelApiClient>().unForceRefresh();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text("Help & Support".tr, style: Get.textTheme.headline5),
                Text("Most frequently asked questions".tr,
                        style: Get.textTheme.caption)
                    .paddingSymmetric(vertical: 5),
                ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.faqs.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 15);
                  },
                  itemBuilder: (context, indexFaq) {
                    return FaqItemWidget(
                        faq: controller.faqs.elementAt(indexFaq));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

mixin Icons {
  static var arrow_back_ios;
}

TextStyle({double letterSpacing, color}) {}

Widget SizedBox({int height}) {}

class Axis {
  static var vertical;
}

class ListView {
  static separated(
      {padding,
      scrollDirection,
      bool shrinkWrap,
      bool primary,
      itemCount,
      Function(context, index) separatorBuilder,
      FaqItemWidget Function(context, indexFaq) itemBuilder}) {}
}

Text(tr, {style}) {}

class MainAxisSize {
  static var max;
}

class MainAxisAlignment {
  static var start;
}

class CrossAxisAlignment {
  static var start;
}

class Column {}

class EdgeInsets {
  static symmetric({int horizontal, int vertical}) {}
}

class SingleChildScrollView {}

class RefreshIndicator {}

class IconThemeData {}

class Get {
  static var theme;

  static var textTheme;

  static find({String tag}) {}

  static back() {}
}

class AppBar {}

class Scaffold {}

Widget Obx(Function() param0) {}

class Widget {}

class BuildContext {}
