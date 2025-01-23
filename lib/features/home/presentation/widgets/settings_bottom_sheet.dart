import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/core/extensions/string_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/shared/ui/widgets/headline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingBottomSheetContent extends StatefulWidget {
  const SettingBottomSheetContent({super.key, required this.entity});

  final SettingsEntity entity;

  @override
  State<SettingBottomSheetContent> createState() => _SettingBottomSheetContentState();
}

class _SettingBottomSheetContentState extends State<SettingBottomSheetContent>
    with SingleTickerProviderStateMixin {

  late final gridTypes = ValueNotifier<GridType>(widget.entity.gridType);

  @override
  Widget build(BuildContext context) {

    SettingsEntity entity = widget.entity.copyWith();

    return SingleChildScrollView(
      padding: Dimensions.normal.padding,
      child: Column(
        spacing: Dimensions.large,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            spacing: Dimensions.large,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Headline('Select your grid type'),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: GridType.values.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final type = GridType.values[index];
                    return ValueListenableBuilder(
                      valueListenable: gridTypes,
                      builder: (context, value, child) {
                        return ElevatedButton(
                          onPressed: () {
                            entity = entity.copyWith(gridType: type);
                            gridTypes.value = type;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: entity.gridType == type ? Colors.blue : Colors.transparent,
                          ),
                          child: Text(
                            type.name.capitalize,
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => Dimensions.small.horizontalBox,
                ),
              ),
            ],
          ),

          Column(
            spacing: Dimensions.large,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Headline('Select your birthday'),
              SizedBox(
                height: 65,
                child: CupertinoDatePicker(
                  initialDateTime: entity.birthday,
                  onDateTimeChanged: (DateTime date) {
                    entity = entity.copyWith(birthday: date);
                  },
                  minimumYear: 1900,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
            ],
          ),

          Column(
            spacing: Dimensions.large,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Headline('Select grid end date'),
              SizedBox(
                height: 65,
                child: CupertinoDatePicker(
                  initialDateTime: entity.endDateTime,
                  onDateTimeChanged: (DateTime date) {
                    entity = entity.copyWith(endDateTime: date);
                  },
                  minimumYear: 1900,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
            ],
          ),

          Padding(
            padding: Dimensions.large.paddingVertical,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {

                  Navigator.of(context).pop(
                    entity.copyWith(
                      birthday: entity.birthday,
                      endDateTime: entity.endDateTime,
                      gridType: entity.gridType,
                    ),
                  );

                },
                child: const Text('Save'),
              ),
            )
          ),

        ],
      ),
    );
  }

}
