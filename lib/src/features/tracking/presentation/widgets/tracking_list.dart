import 'package:flutter/material.dart';

import '../../domain/entites/tracking.dart';
import 'tracking_item.dart';

class TrackingListWidget extends StatelessWidget {
  final List<Tracking> trackingList;
  final Function(int, String) onPressed;

  const TrackingListWidget({
    super.key,
    required this.trackingList,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trackingList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return TrackingItemWidget(
          tracking: trackingList[index],
          onPressed: () {
            onPressed(trackingList[index].id!, trackingList[index].ref!);
          },
        );
      },
    );
  }
}
