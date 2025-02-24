import 'package:days/core/constants/app_constants.dart';
import 'package:days/core/utils/datetime_utils.dart';
import 'package:home_widget/home_widget.dart';

Future<void> updateHomeScreenWidget() async {
  HomeWidget.setAppGroupId(AppConstants.homeWidgetAppGroupId);
  await HomeWidget.saveWidgetData(
    AppConstants.homeWidgetDaysDataKey,
    DateTimeUtils.getDaysFrom(DateTime(DateTime.now().year), DateTime.now()),
  );
  await HomeWidget.updateWidget(
    name: AppConstants.daysHomeWidgetName,
    iOSName: AppConstants.iosHomeWidgetName,
    androidName: AppConstants.androidHomeWidgetName,
  );
}
