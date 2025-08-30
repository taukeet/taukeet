import 'package:flutter/material.dart';

class HomeScreenNew extends StatelessWidget {
  const HomeScreenNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hyderabad, India',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '10:25 AM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.white.withOpacity(0.6),
                    size: 28,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Date Selector
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    _buildDateTab('28 Aug', false),
                    _buildDateTab('29 Aug 2025', true),
                    _buildDateTab('30 Aug', false),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Prayer Times Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.1,
                  children: [
                    _buildPrayerCard(
                      'Fajr',
                      '04:48',
                      'AM',
                      Icons.brightness_2,
                      const Color(0xFF2A2A2A),
                    ),
                    _buildPrayerCard(
                      'Sunrise',
                      '06:02',
                      'AM',
                      Icons.wb_sunny,
                      const Color(0xFF4A6CF7),
                      isHighlighted: true,
                    ),
                    _buildPrayerCard(
                      'Dhuhr',
                      '12:18',
                      'PM',
                      Icons.wb_sunny,
                      const Color(0xFF2A2A2A),
                    ),
                    _buildPrayerCard(
                      'Asr',
                      '03:35',
                      'PM',
                      Icons.account_balance,
                      const Color(0xFF2A2A2A),
                    ),
                    _buildPrayerCard(
                      'Maghrib',
                      '06:32',
                      'PM',
                      Icons.brightness_2,
                      const Color(0xFF2A2A2A),
                    ),
                    _buildPrayerCard(
                      'Isha',
                      '07:42',
                      'PM',
                      Icons.star,
                      const Color(0xFF2A2A2A),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTab(String text, bool isSelected) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A6CF7) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerCard(
    String prayerName,
    String time,
    String period,
    IconData icon,
    Color backgroundColor, {
    bool isHighlighted = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: isHighlighted
            ? Border.all(color: Colors.white.withOpacity(0.1), width: 1)
            : null,
      ),
      clipBehavior: Clip.none,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Icon
          Positioned(
            bottom: 10,
            right: 10,
            child: Icon(
              icon,
              color: Colors.white.withOpacity(0.08),
              size: 80,
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prayerName,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        period,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
