import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:taukeet/src/blocs/home/home_cubit.dart';
import 'package:taukeet/src/blocs/settings/settings_cubit.dart';
import 'package:taukeet/src/entities/prayer_time.dart';
import 'package:taukeet/src/utils/size_library.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final SizeLibrary sizeLibrary = SizeLibrary(context);

    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        BlocProvider.of<HomeCubit>(context).calculatePrayers();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: sizeLibrary.appSize(12),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              BlocBuilder<SettingsCubit, SettingsState>(
                                builder: (context, state) => SizedBox(
                                  width: sizeLibrary.appWidth(context, 60),
                                  child: Text(
                                    state.isFetchingLocation
                                        ? "Fetching location..."
                                        : state.address.address,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: sizeLibrary.appSize(12),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      InkWell(
                        child: Icon(
                          Icons.settings,
                          size: sizeLibrary.appSize(24),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onTap: () => context.pushNamed('settings'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeLibrary.appSize(200),
                    child: Center(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.currentPrayer!.name.english,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: sizeLibrary.appSize(34),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.currentPrayer!.name.arabic,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: sizeLibrary.appSize(18),
                                      fontFamily: "Lateef",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<HomeCubit>(context)
                                  .changeToPrevDate();
                            },
                            child: Icon(
                              Icons.arrow_left_rounded,
                              size: sizeLibrary.appSize(40),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Expanded(
                            child: BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<HomeCubit>(context)
                                        .changeToToday();
                                  },
                                  child: Text(
                                    DateFormat('EEE dd MMM, yyyy')
                                        .format(state.dateTime)
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: sizeLibrary.appSize(12),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<HomeCubit>(context)
                                  .changeToNextDate();
                            },
                            child: Icon(
                              Icons.arrow_right_rounded,
                              size: sizeLibrary.appSize(40),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(sizeLibrary.appSize(12)),
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              return ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final PrayerTime prayer =
                                      state.prayers[index];

                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          prayer.name.english,
                                          style: TextStyle(
                                            fontSize: sizeLibrary.appSize(12),
                                            fontWeight: prayer.isCurrentPrayer
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          DateFormat('hh:mm a')
                                              .format(prayer.startTime),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: sizeLibrary.appSize(16),
                                            fontWeight: prayer.isCurrentPrayer
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          prayer.name.arabic,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: sizeLibrary.appSize(16),
                                            fontFamily: "Lateef",
                                            fontWeight: prayer.isCurrentPrayer
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 12,
                                  );
                                },
                                itemCount: state.prayers.length,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
