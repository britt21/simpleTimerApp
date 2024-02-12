
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define navigation events
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class HomeNavigation extends NavigationEvent {}

class CreateTaskNavigation extends NavigationEvent {}


class NavigationBloc extends Bloc<NavigationEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationBloc({required this.navigatorKey}) : super(null) {
    // Register event handlers
    on<HomeNavigation>(_onHomeNavigation);
    on<CreateTaskNavigation>(_onCreateTaskNavigation);
  }

  void _onHomeNavigation(HomeNavigation event, Emitter<dynamic> emit) {
    navigatorKey.currentState?.pushNamed('/home_dashboard');
  }

  void _onCreateTaskNavigation(
      CreateTaskNavigation event, Emitter<dynamic> emit) {
    navigatorKey.currentState?.pushNamed('/create_task');
  }
}
