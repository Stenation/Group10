import 'dart:math';

import 'package:flutter/material.dart';

import 'models/team_member.dart';
import 'widgets/member_navigation_controls.dart';
import 'widgets/member_profile_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Profile App',
      theme: ThemeData(colorSchemeSeed: Colors.grey, useMaterial3: true),
      home: const TeamPage(),
    );
  }
}

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  int currentIndex = 0;

  final List<TeamMember> members = [
    const TeamMember(
      name: 'Valeriia',
      country: 'Russia',
      hobbies: 'Reading, Bachata',
      image: 'assets/images/member1.png',
    ),
    const TeamMember(
      name: 'Steffen',
      country: 'Germany',
      hobbies: 'Football',
      image: 'assets/images/member2.png',
    ),
    const TeamMember(
      name: 'Błażej',
      country: 'Poland',
      hobbies: 'Playing the piano, Reading',
      image: 'assets/images/member3.png',
    ),
    const TeamMember(
      name: 'Sariph',
      country: 'Nepal',
      hobbies: 'Playing guitar and sports',
      image: 'assets/images/member4.jpg',
    ),
    const TeamMember(
      name: 'Abhay',
      country: 'Nepal',
      hobbies: 'Sports, Chess, Guitar',
      image: 'assets/images/member5.png',
    ),
    const TeamMember(
      name: 'Michał',
      country: 'Poland',
      hobbies: 'Coding, Sleeping',
      image: 'assets/images/member6.jpg',
    ),
    const TeamMember(
      name: 'Olive Schilde',
      country: 'Finland',
      hobbies: 'Mobile app development course',
      image: 'assets/images/member7.png',
    ),
  ];

  void nextMember() {
    setState(() {
      currentIndex = (currentIndex + 1) % members.length;
    });
  }

  void previousMember() {
    setState(() {
      currentIndex = (currentIndex - 1 + members.length) % members.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final member = members[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Team Profile App')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final orientation = MediaQuery.of(context).orientation;
          final cardHeight = orientation == Orientation.portrait
              ? min(constraints.maxHeight * 0.62, 520.0)
              : min(constraints.maxHeight * 0.625, 312.5);
          final cardWidth = orientation == Orientation.portrait
              ? min(constraints.maxWidth * 0.85, cardHeight * 0.85)
              : min(constraints.maxWidth * 0.8, 600.0);

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: orientation == Orientation.portrait
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Team #10',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The best international team ever',
                        style: TextStyle(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),

                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: cardWidth,
                            maxHeight: cardHeight,
                          ),
                          child: MemberProfileCard(
                            member: member,
                            avatarSize: 120,
                            contentPadding: const EdgeInsets.all(20.0),
                            nameFontSize: 26,
                            bodyFontSize: 16,
                            memberSpacing: 24,
                            textSpacing: 8,
                          ),
                        ),
                      ),

                      SizedBox(height: 28),

                      MemberNavigationControls(
                        onPrevious: previousMember,
                        onNext: nextMember,
                        buttonPadding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 10.0,
                        ),
                        fontSize: 18,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 50.0,
                            right: 16.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Team #10',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'The best international team ever',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: cardWidth,
                                  maxHeight: cardHeight,
                                ),
                                child: MemberProfileCard(
                                  member: member,
                                  avatarSize: 100,
                                  contentPadding: const EdgeInsets.all(16.0),
                                  nameFontSize: 22,
                                  bodyFontSize: 14,
                                  memberSpacing: 20,
                                  textSpacing: 6,
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            MemberNavigationControls(
                              onPrevious: previousMember,
                              onNext: nextMember,
                              buttonPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
