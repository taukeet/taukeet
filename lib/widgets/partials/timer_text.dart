import 'package:flutter/material.dart';
import 'package:taukeet/bloc/timer_bloc.dart';
import 'package:provider/provider.dart';

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final hourStr = (duration / 3600).floor().toString().padLeft(2, "0");
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$hourStr:$minutesStr:$secondsStr',
      style: const TextStyle(
        fontSize: 16,
        letterSpacing: 2,
        color: Color(0xffF0E7D8),
      ),
    );
  }
}
