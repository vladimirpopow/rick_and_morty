import 'package:flutter/material.dart';
import 'package:rick_and_morty_test/common/app_colors.dart';
import 'package:rick_and_morty_test/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_test/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({super.key, required this.person});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Персонаж'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Column(children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            person.name!,
            style: const TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            child: PersonCacheImage(
                height: 260, width: 260, imageUrl: person.image!),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                person.status!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                maxLines: 1,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          if (person.type!.isNotEmpty) ...buildText('Тип:', person.type!),
          ...buildText('Пол:', person.gender!),
          ...buildText('Номер эпизода:', person.episode.length.toString()),
          ...buildText('Расса:', person.species!),
          ...buildText('Последнее местонахождение:', person.location!.name!),
          ...buildText('Планета:', person.origin!.name!),
          ...buildText('Был рожден:', person.created!.toString())
        ]),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: const TextStyle(
          color: AppColors.greyColor,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }
}
