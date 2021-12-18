import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroSlider(
        showSkipBtn: false,
        slides: [
          Slide(
            widgetDescription: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xffF0E7D8),
                    size: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "We need your location to calculate the prayer times",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffF0E7D8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffF0E7D8),
                      shadowColor: const Color(0xffF0E7D8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Locate",
                      style: TextStyle(
                        color: Color(0xff191923),
                      ),
                    ),
                  )
                ],
              ),
            ),
            backgroundColor: const Color(0xff191923),
          ),
          Slide(
            widgetDescription: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_clock,
                    color: Color(0xffF0E7D8),
                    size: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please select the madhab, Asr time depends on it",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffF0E7D8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    hint: const Text("Select Madhab"),
                    dropdownColor: const Color(0xff191923),
                    style: const TextStyle(
                      color: Color(0xffF0E7D8),
                    ),
                    value: "hanfi",
                    items: const [
                      DropdownMenuItem(
                        child: Text("Hanfi"),
                        value: "hanfi",
                      ),
                      DropdownMenuItem(
                        child: Text("Others"),
                        value: "others",
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xff191923),
          ),
          Slide(
            widgetDescription: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calculate,
                    color: Color(0xffF0E7D8),
                    size: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please select the calulation method",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffF0E7D8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    hint: const Text("Select Calculation Method"),
                    dropdownColor: const Color(0xff191923),
                    style: const TextStyle(
                      color: Color(0xffF0E7D8),
                    ),
                    value: "hanfi",
                    items: const [
                      DropdownMenuItem(
                        child: Text("Hanfi"),
                        value: "hanfi",
                      ),
                      DropdownMenuItem(
                        child: Text("Others"),
                        value: "others",
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xff191923),
          ),
        ],
      ),
    );
  }
}
