import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'about_section_state.dart';

class AboutSectionCubit extends Cubit<AbuotSectionState> {
  AboutSectionCubit() : super(AbuotSectionInitial());
}
