// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:flutter/material.dart';

class PersonFieldGrid extends StatelessWidget {
  const PersonFieldGrid({super.key, this.person, this.countryName});
  final PeopleEntity? person;
  final String? countryName;

  @override
  Widget build(BuildContext context) {
    final columns = MediaQuery.of(context).size.width > 600 ? 3 : 2;
    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _field(Icons.numbers, ' Notional No', person?.nationalNo ?? '???'),
        _field(
          Icons.wc_outlined,
          'Gender',
          person?.gender == 0 ? 'Male' : 'Female',
        ),
        _field(
          Icons.cake_outlined,
          ' Date of Birth',
          person?.dateOfBirth ?? '???',
        ),
        _field(Icons.phone_outlined, 'Phone', person?.phone ?? '—'),
        _field(
          Icons.email_outlined,
          'Email',
          person?.email ?? ' Don\'t Have',
          wide: true,
        ),
        _field(Icons.public, 'Country', countryName ?? 'N/A'),
        _field(
          Icons.location_on_outlined,
          'Address',
          person?.address ?? '???',
          wide: true,
        ),
      ],
    );
  }
}

Widget _field(IconData icon, String key, String value, {bool wide = false}) =>
    Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 15, color: const Color(0xFF6A5AE0)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: Color(0xFF8A8FA3),
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
