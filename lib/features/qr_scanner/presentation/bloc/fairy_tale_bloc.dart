import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import '../../data/model/fairy_tale_dto.dart';
import '/core/resources/usecase.dart';
import '../../domain/usecases/get_qr_codes.dart';
import '../../domain/usecases/get_tales.dart';
import '/core/resources/enums.dart';
import '/core/resources/failures.dart';
import '../../data/model/qr_codes_dto.dart';

part 'fairy_tale_event.dart';

part 'fairy_tale_state.dart';

part 'fairy_tale_bloc.freezed.dart';

class FairyTaleBloc extends Bloc<FairyTaleEvent, FairyTaleState> {
  final GetQRCodes getQRCodes;
  final GetTales getTales;

  FairyTaleBloc({
    required this.getTales,
    required this.getQRCodes,
  }) : super(const FairyTaleState()) {
    on<_GetQRCodes>(_getQRCodes);
    on<_GetTales>(_getTales);
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
      ),
      (right) => emit(
        state.copyWith.call(
          qrCodes: right,
          status: Statuses.success,
        ),
      ),
    );
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
      ),
      (right) {
        emit(
          state.copyWith.call(
            fairyTale: right,
            status: Statuses.success,
          ),
        );
      }
    );
  }
}
