import 'package:flutter/material.dart';

import '../core/styles.dart';
import '../models/donation.dart';

class DonationCard extends StatelessWidget {
  final Donation donation;
  final void Function() onPressed;

  const DonationCard({
    Key key,
    @required this.donation,
    @required this.onPressed,
  }) : assert(donation != null),
       assert(onPressed != null),
       super(key: key);

  @override
  Widget build(BuildContext context) =>
    Stack(
      children: <Widget>[
        // card content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // image
            Container(
              height: 300,
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: kInactiveColor,
                image: DecorationImage(
                  image: donation.images.first.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // description
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                donation.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: kLightColor,
                  fontSize: kTextH5Size,
                ),
              ),
            ),

            // donor
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // name
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 128,
                    ),
                    child: Text(
                      donation.donor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kLightColor,
                        fontSize: kTextH7Size,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // photo
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: kInactiveColor,
                      image: DecorationImage(
                        image: donation.donor.photo,
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // tap effect
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: onPressed,
            ),
          ),
        ),
      ],
    );
}
