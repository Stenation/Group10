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

  List<Widget> _buildInfoChips() {
    return [
      Chip(
        avatar: Icon(Icons.public, size: bodyFontSize),
        label: Text(member.country, style: TextStyle(fontSize: bodyFontSize)),
        visualDensity: VisualDensity.compact,
      ),
      Chip(
        avatar: Icon(Icons.interests, size: bodyFontSize),
        label: Text(member.hobbies, style: TextStyle(fontSize: bodyFontSize)),
        visualDensity: VisualDensity.compact,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: contentPadding,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final useVerticalLayout =
                orientation == Orientation.portrait &&
                constraints.maxWidth < 500;

            if (useVerticalLayout) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: _buildAvatar(member.image)),
                  SizedBox(height: memberSpacing * 0.6),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      member.name,
                      style: TextStyle(
                        fontSize: nameFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: textSpacing + 2),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: textSpacing,
                      runSpacing: textSpacing,
                      children: _buildInfoChips(),
                    ),
                  ),
                ],
              );
            }

            return Row(
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
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: textSpacing,
                        runSpacing: textSpacing,
                        children: _buildInfoChips(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
