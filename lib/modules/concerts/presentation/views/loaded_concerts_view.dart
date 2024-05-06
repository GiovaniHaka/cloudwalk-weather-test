import 'package:cloudwalk/modules/concerts/presentation/widgets/concert_item.dart';
import 'package:flutter/widgets.dart';

import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';

/// [LoadedConcertsView] is a view that displays a list of [ConcertEntity].
class LoadedConcertsView extends StatelessWidget {
  final List<ConcertEntity> concerts;
  final ValueChanged<ConcertEntity> onTapConcert;

  const LoadedConcertsView({
    Key? key,
    required this.concerts,
    required this.onTapConcert,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemBuilder: (context, index) {
            final concert = concerts[index];

            return ConcertItem(
              concert: concert,
              onTap: () {
                onTapConcert(concert);
              },
            );
          },
          itemCount: concerts.length,
        ),
      ],
    );
  }
}
