import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/fairy_tale_dto.dart';
import '../../data/model/qr_codes_dto.dart';
import '../../domain/usecases/get_qr_codes.dart';
import '../../domain/usecases/get_tales.dart';
import '/core/resources/boxes.dart';
import '/core/resources/enums.dart';
import '/core/resources/failures.dart';
import '/core/resources/usecase.dart';
import '/features/qr_scanner/data/model/local/fairy_tale_local.dart';

part 'fairy_tale_bloc.freezed.dart';
part 'fairy_tale_event.dart';
part 'fairy_tale_state.dart';

class FairyTaleBloc extends Bloc<FairyTaleEvent, FairyTaleState> {
  final GetQRCodes getQRCodes;
  final GetTales getTales;

  FairyTaleBloc({required this.getTales, required this.getQRCodes})
      : super(const FairyTaleState()) {
    on<_GetQRCodes>(_getQRCodes);
    on<_GetTales>(_getTales);
    on<_HasInLocal>(_hasInLocal);
  }

  void _getQRCodes(_GetQRCodes event, Emitter<FairyTaleState> emit) async {
    emit(
      state.copyWith.call(
        status: Statuses.loading,
      ),
    );
    final response = await getQRCodes.call(NoParams());
    response.fold(
        (left) => emit(
              state.copyWith.call(
                status: Statuses.error,
                error: left,
              ),
            ), (right) {
      qrCodesLocalBox.addAll(right.qr_codes ?? []);
      emit(
        state.copyWith.call(
          qrCodes: right,
          status: Statuses.success,
        ),
      );
    });
  }

  void _hasInLocal(_HasInLocal event, Emitter<FairyTaleState> emit) async {
    emit(
      state.copyWith.call(
        status: Statuses.loading,
      ),
    );
    FairyTaleLocal? fairyTaleLocal = await event.local;
    if (fairyTaleLocal == null) {
      emit(state.copyWith.call(
        status: Statuses.error,
      ));
    } else {
      emit(
        state.copyWith.call(
          status: Statuses.success,
          fairyTale: FairyTaleDto(
            id: fairyTaleLocal.id,
            qrCodes: fairyTaleLocal.qrCodes,
            pics: fairyTaleLocal.pics,
            musics: fairyTaleLocal.musics,
            titleId: fairyTaleLocal.titleId,
            titles: fairyTaleLocal.titles,
          ),
        ),
      );
    }
  }

  void _getTales(_GetTales event, Emitter<FairyTaleState> emit) async {
    emit(
      state.copyWith.call(
        status: Statuses.loading,
      ),
    );

    final response = await getTales.call(event.qrCode ?? '');
    response.fold(
        (left) => emit(
              state.copyWith.call(
                status: Statuses.error,
                error: left,
              ),
            ), (right) {
      emit(
        state.copyWith.call(
          fairyTale: right,
          status: Statuses.success,
        ),
      );
    });
  }
}
