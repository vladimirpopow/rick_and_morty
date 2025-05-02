import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_test/common/app_colors.dart';
import 'package:rick_and_morty_test/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_test/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;

  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            child: PersonCacheImage(
              height: 166,
              width: 166,
              imageUrl: person.image!,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                person.name!,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        color: person.status == 'Alive'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Text(
                    '${person.status} - ${person.species}',
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
              const Text(
                'Last known location:',
                style: TextStyle(color: AppColors.greyColor),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                person.location!.name!,
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Origin',
                style: TextStyle(color: AppColors.greyColor),
              ),
              Text(
                person.origin!.name!,
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          )),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
