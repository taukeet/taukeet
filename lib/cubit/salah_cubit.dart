import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'salah_state.dart';

class SalahCubit extends Cubit<SalahState> {
  SalahCubit() : super(SalahInitial());
}
