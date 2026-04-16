import 'package:flutter/material.dart';

import '../models/team_member.dart';

class MemberProfileCard extends StatelessWidget {
  final TeamMember member;
  final double avatarSize;
  final EdgeInsetsGeometry contentPadding;
  final double nameFontSize;
  final double bodyFontSize;
  final double memberSpacing;
  final double textSpacing;

  const MemberProfileCard({
    super.key,
    required this.member,
    required this.avatarSize,
    required this.contentPadding,
    required this.nameFontSize,
    required this.bodyFontSize,
    required this.memberSpacing,
    required this.textSpacing,
  });

  Widget _buildAvatar(String imagePath) {
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: avatarSize,
        height: avatarSize,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/default.png',
            width: avatarSize,
            height: avatarSize,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: contentPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAvatar(member.image),
            SizedBox(width: memberSpacing),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: TextStyle(
                      fontSize: nameFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: textSpacing + 2),
                  Text(
                    'Home country: ${member.country}',
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: textSpacing),
                  Text(
                    'Hobbies: ${member.hobbies}',
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
