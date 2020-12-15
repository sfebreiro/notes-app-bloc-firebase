import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  // ignore: must_call_super
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onEvent(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print('$error: $stacktrace');
    super.onError(bloc, error, stacktrace);
  }
}
