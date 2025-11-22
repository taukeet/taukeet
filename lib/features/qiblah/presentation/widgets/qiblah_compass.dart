import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:taukeet/generated/l10n.dart';

class QiblahCompass extends StatefulWidget {
  final double qiblahDirection;

  const QiblahCompass({super.key, required this.qiblahDirection});

  @override
  State<QiblahCompass> createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  double? _heading;
  double? _accuracy;
  bool _calibrationWarningShown = false;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events?.listen((CompassEvent event) {
      if (event.heading != null) {
        // Normalize heading to 0-359 range
        double normalizedHeading = event.heading!;

        // Convert negative values to positive equivalent
        while (normalizedHeading < 0) {
          normalizedHeading += 360;
        }

        // Ensure it's within 0-359 range
        normalizedHeading = normalizedHeading % 360;

        setState(() {
          _heading = normalizedHeading;
          _accuracy = event.accuracy;
        });

        // Show calibration warning if needed (only once)
        if (!isCompassReliable && !_calibrationWarningShown) {
          _showCalibrationDialog();
          _calibrationWarningShown = true;
        }
      }
    });
  }

  void _showCalibrationDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.amber, size: 28),
                  SizedBox(width: 10),
                  Text(
                    S.of(context)!.qiblahCompassCalibration,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context)!.qiblahCompassCalibrationMessage,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          S.of(context)!.qiblahCompassHowToCalibrate,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('1. ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(S
                                    .of(context)!
                                    .qiblahCompassCalibrationStep1)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text('2. ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(S
                                    .of(context)!
                                    .qiblahCompassCalibrationStep2)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text('3. ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(S
                                    .of(context)!
                                    .qiblahCompassCalibrationStep3)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text('4. ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(S
                                    .of(context)!
                                    .qiblahCompassCalibrationStep4)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lightbulb_outline,
                            color: Colors.amber.shade700, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            S.of(context)!.qiblahCompassCalibrationTip,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.amber.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    S.of(context)!.qiblahCompassCalibrationLater,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Reset flag to allow showing dialog again after some time
                    Future.delayed(Duration(minutes: 2), () {
                      _calibrationWarningShown = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(S.of(context)!.qiblahCompassCalibrationGotIt),
                ),
              ],
            );
          },
        );
      }
    });
  }

  // FIXED: Proper angle calculation
  double _calculateDifference() {
    if (_heading == null) return 999;

    // Ensure heading is properly normalized (failsafe)
    double normalizedHeading = _heading!;
    while (normalizedHeading < 0) {
      normalizedHeading += 360;
    }
    normalizedHeading = normalizedHeading % 360;

    double difference = (widget.qiblahDirection - normalizedHeading).abs();

    // Handle the circular nature of compass (e.g., 359° vs 1° = 2° difference, not 358°)
    if (difference > 180) {
      difference = 360 - difference;
    }

    return difference;
  }

  bool get isFacingQiblah {
    if (_heading == null) return false;

    double difference = _calculateDifference();
    return difference <= 5;
  }

  // FIXED: Proper relative angle calculation for the external indicator
  double get qiblahRelativeAngle {
    if (_heading == null) return widget.qiblahDirection * (pi / 180);

    // Ensure heading is properly normalized (failsafe)
    double normalizedHeading = _heading!;
    while (normalizedHeading < 0) {
      normalizedHeading += 360;
    }
    normalizedHeading = normalizedHeading % 360;

    double angleDiff = widget.qiblahDirection - normalizedHeading;

    // Normalize angle to -180 to +180 range for proper rotation
    while (angleDiff > 180) {
      angleDiff -= 360;
    }
    while (angleDiff < -180) {
      angleDiff += 360;
    }

    return angleDiff * (pi / 180);
  }

  // Check if compass is reliable
  bool get isCompassReliable {
    return _accuracy != null && _accuracy! >= 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context)!.qiblahCompassDirection(
              widget.qiblahDirection.toStringAsFixed(2)),
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        const SizedBox(height: 10),

        // Status indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isFacingQiblah ? Colors.green : Colors.orange,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isFacingQiblah ? Icons.check_circle : Icons.explore,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isFacingQiblah
                    ? S.of(context)!.qiblahCompassFacingQiblah
                    : S.of(context)!.qiblahCompassTurnToFindQiblah,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // Outer ring with Qiblah indicator
        SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring for Qiblah direction indicator
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
              ),

              // External Qiblah direction indicator
              Transform.rotate(
                angle: qiblahRelativeAngle,
                child: Transform.translate(
                  offset: const Offset(0, -150), // Position outside the compass
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isFacingQiblah ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.navigation,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),

              // Compass (rotates with device heading)
              Transform.rotate(
                angle: (_heading ?? 0) * (pi / 180) * -1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Compass background
                    Image.asset(
                      'assets/icons/compass_background.png',
                      width: 250,
                      height: 250,
                    ),
                    // Compass needle (always points North)
                    Image.asset(
                      'assets/icons/compass_needle.png',
                      scale: 2,
                    ),
                  ],
                ),
              ),

              // Center dot
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isFacingQiblah ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Enhanced direction info with debugging
        if (_heading != null)
          Column(
            children: [
              Text(
                S
                    .of(context)!
                    .qiblahCompassCurrentHeading(_heading!.toStringAsFixed(1)),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                S.of(context)!.qiblahCompassQiblahDirection(
                    widget.qiblahDirection.toStringAsFixed(1)),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                S.of(context)!.qiblahCompassDifference(
                    _calculateDifference().toStringAsFixed(1)),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isFacingQiblah ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (_accuracy != null)
                Text(
                  S
                      .of(context)!
                      .qiblahCompassAccuracy(_accuracy!.toStringAsFixed(1)),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isCompassReliable ? Colors.green : Colors.red,
                      ),
                ),
            ],
          ),
      ],
    );
  }
}
