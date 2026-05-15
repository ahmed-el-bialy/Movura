import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_content_state.dart';

class MainContentCubit extends Cubit<MainContentState> {
  MainContentCubit() : super(MainContentInitial());
}
