import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../common/ui.dart';
import '../../../models/notification_model.dart' as model;

class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget({key, this.notification, this.onDismissed, this.onTap})
      : super(key: key);
  final model.Notification notification;
  final ValueChanged<model.Notification> onDismissed;
  final ValueChanged<model.Notification> onTap;

  @override
  Widget build(BuildContext context) {
    // AuthService _authService = Get.find<AuthService>();
    var boxDecoration = BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
      borderRadius: BorderRadius.circular(150),
    );
    var boxDecoration2 = boxDecoration;
    var boxDecoration22 = boxDecoration2;
    var boxDecoration222 = boxDecoration22;
    var boxDecoration2222 = boxDecoration222;
    var boxDecoration22222 = boxDecoration2222;
    var EdgeInsets;
    var get = Get;
    var get2 = Get;
    var Get;
    var crossAxisAlignment2 = CrossAxisAlignment;
    var mainAxisSize2 = MainAxisSize;
    var mainAxisAlignment2 = MainAxisAlignment;
    var column = Column;
    var sizedBox = SizedBox;
    var children3 = <Widget>[
      Text(
        this.notification.getMessage(),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: Get.textTheme.bodyText1.merge(TextStyle(
            fontWeight: notification.read ? FontWeight.w300 : FontWeight.w600)),
      ),
      Text(
        DateFormat('d, MMMM y | HH:mm').format(this.notification.createdAt),
        style: Get.textTheme.caption,
      )
    ];
    var container = Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(150),
      ),
    );
    var container2 = container;
    var positioned = Positioned;
    var newVariable = positioned(
      left: -20,
      top: -55,
      child: container2,
    );
    var newVariable2 = newVariable;
    var spaceEvenly;
    var max;
    var stretch;
    var children2 = <Widget>[
      Stack(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Get.theme.focusColor.withOpacity(1),
                      Get.theme.focusColor.withOpacity(0.2),
                    ])),
            child: Icon(
              Icons.notifications_outlined,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 50,
            ),
          ),
          Positioned(
            right: -15,
            bottom: -30,
            child: Container(
              width: 60,
              height: 60,
              decoration: boxDecoration22222,
            ),
          ),
          newVariable2
        ],
      ),
      sizedBox(width: 15),
      Expanded(
        child: column(
          crossAxisAlignment: crossAxisAlignment2.stretch,
          mainAxisAlignment: mainAxisAlignment2.spaceEvenly,
          mainAxisSize: mainAxisSize2.max,
          children: children3,
        ),
      )
    ];
    var row = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: children2,
    );
    const edgeInsets3 = const EdgeInsets.symmetric(horizontal: 20);
    const edgeInsets = edgeInsets3;
    var edgeInsets2 = edgeInsets;
    var padding2 = Padding(
      padding: edgeInsets2,
      child: Icon(
        Icons.delete_outline,
        color: Colors.white,
      ),
    );
    var padding22 = padding2;
    var centerRight2 = Alignment.centerRight;
    var centerRight = centerRight2;
    var colors3 = Colors;
    var colors2 = colors3;
    return Dismissible(
      key: Key(this.notification.hashCode.toString()),
      background: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: Ui.getBoxDecoration(color: colors2.red),
        child: Align(
          alignment: centerRight,
          child: padding22,
        ),
      ),
      onDismissed: (direction) {
        onDismissed(this.notification);
        // Then show a snackbar
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: "The notification is deleted".tr));
      },
      child: GestureDetector(
        onTap: () {
          if (!notification.read) {
            onTap(notification);
          }
        },
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: Ui.getBoxDecoration(
              color: this.notification.read
                  ? get.theme.primaryColor
                  : get2.theme.focusColor.withOpacity(0.15)),
          child: row,
        ),
      ),
    );
  }

  BoxDecoration({color, borderRadius, gradient}) {}

  Text(String message, {overflow, int maxLines, style}) {}

  LinearGradient({begin, end, List colors}) {}

  Stack({List<Widget> children}) {}
}

class DateFormat {
  DateFormat(String s);

  String format(DateTime createdAt) {}
}

class TextOverflow {
  static var ellipsis;
}

class SizedBox {}

class Column {}

class MainAxisAlignment {
  static var start;
}

class MainAxisSize {}

class BuildContext {}

class BorderRadius {
  static circular(int i) {}
}

class Theme {
  static of(context) {}
}

class Key {}

mixin Key {}

class Key {}

class Key {}

class ValueChanged {}

class Key {}

class Key {}

class StatelessWidget {}

class FontWeight {
  static var w600;
}

class Colors {
  static var green;

  static var redAccent;

  static var white;
}

class Alignment {
  static var centerRight;

  static var bottomLeft;

  static var topRight;
}

Align({alignment, Padding child}) {}

Key(String string) {}

Dismissible({key, background, Null Function(direction) onDismissed, child}) {}

class Padding {}

Positioned({int right, int bottom, child}) {}

Expanded({child}) {}

Row({mainAxisAlignment, List children}) {}

GestureDetector({Null Function() onTap, child}) {}

Container({padding, margin, decoration, child, int width, int height}) {}
