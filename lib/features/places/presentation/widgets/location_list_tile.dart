import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    super.key,
    required this.location,
    required this.callback,
  });

  final String location;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: ListTile(
            onTap: callback,
            leading: const Icon(
              Icons.location_city,
              color: Colors.white,
            ),
            horizontalTitleGap: 0,
            title: Text(
              location,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Divider(
          thickness: 2,
          height: 2,
          color: Colors.white,
        )
      ],
    );
  }
}
