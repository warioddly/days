import 'package:days/features/home/domain/entity/settings_entity.dart';
import 'package:days/features/home/domain/usecase/get_settings_usecase.dart';
import 'package:days/features/home/domain/usecase/set_settings_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SetSettingsUseCase setSettingsUseCase;
  final GetSettingsUseCase getSettingsUseCase;

  SettingsBloc({
    required this.setSettingsUseCase,
    required this.getSettingsUseCase,
  }) : super(SettingsState.initial()) {
    _setup();
  }

  void _setup() {
    on<GetSettings>(getSettings);
    on<SetSettings>(setSettings);
  }

  Future<void> getSettings(
    GetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(state: SettingsLoading()));

      final entity = await getSettingsUseCase(null);

      emit(state.copyWith(entity: entity, state: SettingsLoaded()));
    } catch (e) {
      emit(state.copyWith(state: SettingsError(e)));
    }
  }

  Future<void> setSettings(
    SetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(state: SettingsLoading()));
      await setSettingsUseCase(event.entity);
      emit(state.copyWith(entity: event.entity));

      add(GetSettings());
    } catch (e) {
      emit(state.copyWith(state: SettingsError(e)));
    }
  }
}
