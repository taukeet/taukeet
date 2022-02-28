import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taukeet/bloc/timer_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taukeet/widgets/settings.dart';

class DateTimeText extends StatelessWidget {
  const DateTimeText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.select((TimerBloc bloc) => bloc.state.duration);
    DateTime now = DateTime.now();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('EEEE d MMMM').format(now).toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 1,
            color: Color(0xffF0E7D8),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              DateFormat('hh:mm a').format(now),
              style: const TextStyle(
                fontSize: 20,
                letterSpacing: 1,
                color: Color(0xffF0E7D8),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              iconSize: 24,
              icon: const Icon(
                Icons.settings,
                color: Color(0xffF0E7D8),
              ),
            ),
          ],
        )
      ],
    );
  }
}
