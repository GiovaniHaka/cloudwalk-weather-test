import 'package:cloudwalk/modules/concerts/presentation/widgets/concert_item.dart';
import 'package:flutter/widgets.dart';

import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';

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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(viewPadding),
            child: Text(
              Language.instance.lang.concerts,
              style: AppTextStyle.headlineMedium(),
            ),
          ),
        ),
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
