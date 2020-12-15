part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;

  ThemeState({@required this.themeData});

  @override
  List<Object> get props => [themeData];

  @override
  String toString() => 'ThemeState {themeData: $themeData}';
}
