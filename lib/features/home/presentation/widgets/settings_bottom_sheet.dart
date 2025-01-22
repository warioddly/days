import 'package:days/core/constants/dimensions.dart';
import 'package:days/core/extensions/dimensions_extensions.dart';
import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/presentation/bloc/settings/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBottomSheetContent extends StatefulWidget {
  const SettingBottomSheetContent({super.key});

  @override
  State<SettingBottomSheetContent> createState() => _SettingBottomSheetContentState();
}

class _SettingBottomSheetContentState extends State<SettingBottomSheetContent> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {

    final settingsBloc = context.read<SettingsBloc>();
    final settings = settingsBloc.state.entity;
    SettingsEntity entity = settings.copyWith();

    return SingleChildScrollView(
      padding: Dimensions.normal.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          headline('Select your view type'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: GridType.values.length,
            padding: Dimensions.normal.padding,
            itemBuilder: (context, index) {
              final type = GridType.values[index];
              return ListTile(
                title: Text(type.name),
                onTap: () {
                  entity = entity.copyWith(gridType: type);
                },
                trailing: entity.gridType == type ? const Icon(Icons.check) : null,
              );
            },
          ),
      
          headline('Select your birthday'),
          SizedBox(
            height: 130,
            child: CupertinoDatePicker(
              initialDateTime: entity.birthday,
              onDateTimeChanged: (DateTime date) {
                print(date);
              },
              use24hFormat: true,
              minimumYear: 1900,
              minuteInterval: 1,
              itemExtent: 50,
              mode: CupertinoDatePickerMode.date,
            ),
          ),
      
          headline('Select grid end date'),
          SizedBox(
            height: 140,
            child: CupertinoDatePicker(
              initialDateTime: entity.endDateTime,
              onDateTimeChanged: (DateTime date) {
                print(date);
              },
              use24hFormat: true,
              minimumYear: 1900,
              minuteInterval: 1,
              itemExtent: 50,
              mode: CupertinoDatePickerMode.date,
            ),
          ),
      
          CupertinoButton(
            child: const Text('Save'),
            onPressed: () {
      
              if (settings.birthday.isAfter(settings.endDateTime)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Birthday cannot be after end date'),
                  ),
                );
                return;
              }
      
              settingsBloc.add(
                SetSettings(
                  settings.copyWith(
                    birthday: entity.birthday,
                    endDateTime: entity.endDateTime,
                    gridType: entity.gridType,
                  ),
                )
              );
      
              Navigator.of(context).pop();
      
            },
          )
      
        ],
      ),
    );
  }

  Text headline(String title) => Text(
    title,
    textAlign: TextAlign.start,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

}
