import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class TeamMember {
  final String name;
  final String country;
  final String hobbies;
  final String image;

  TeamMember({
    required this.name,
    required this.country,
    required this.hobbies,
    required this.image,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Profile App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: TeamPage(),
    );
  }
}

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  int currentIndex = 0;

  final List<TeamMember> members = [
    TeamMember(
      name: 'Valeriia',
      country: 'Russia',
      hobbies: 'Reading, Bachata',
      image: 'assets/images/member1.png',
    ),
    TeamMember(
      name: 'Member 2',
      country: 'Spain',
      hobbies: 'Programming',
      image: 'assets/images/member2.png',
    ),
    TeamMember(
      name: 'Member 3',
      country: 'Dreamland',
      hobbies: 'Photography',
      image: 'assets/images/member3.png',
    ),
    TeamMember(
      name: 'Member 4',
      country: 'Dreamland',
      hobbies: 'Gaming',
      image: 'assets/images/member4.png',
    ),
    TeamMember(
      name: 'Member 5',
      country: 'Dreamland',
      hobbies: 'Drawing',
      image: 'assets/images/member5.png',
    ),
    TeamMember(
      name: 'Member 6',
      country: 'Dreamland',
      hobbies: 'Dancing',
      image: 'assets/images/member6.png',
    ),
    TeamMember(
      name: 'Member 7',
      country: 'Dreamland',
      hobbies: 'Hiking',
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

  Widget buildAvatar(String imagePath, {double size = 120}) {
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/default.png',
            width: size,
            height: size,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final member = members[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Team Profile App'),
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildAvatar(member.image),
                                  SizedBox(width: 24),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          member.name,
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Home country: ${member.country}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Hobbies: ${member.hobbies}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 28),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: previousMember,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                              child: Text('←', style: TextStyle(fontSize: 18)),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: nextMember,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                              child: Text('→', style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0, right: 16.0),
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
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        buildAvatar(member.image, size: 100),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                member.name,
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Home country: ${member.country}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                'Hobbies: ${member.hobbies}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: previousMember,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child: Text('←', style: TextStyle(fontSize: 16)),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: nextMember,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child: Text('→', style: TextStyle(fontSize: 16)),
                                  ),
                                ),
                              ],
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