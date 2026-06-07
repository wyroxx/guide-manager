import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/core/utils/date_formatter.dart';
import 'package:guide_manager/features/excursions/data/excursions_repository_impl.dart';
import 'package:guide_manager/features/excursions/presentation/widgets/calendar.dart';
import 'package:guide_manager/features/excursions/presentation/widgets/excursion_card.dart';

class ExcursionsPage extends ConsumerStatefulWidget {
  const ExcursionsPage({super.key});

  @override
  ConsumerState<ExcursionsPage> createState() => _ExcursionsPageState();
}

class _ExcursionsPageState extends ConsumerState<ExcursionsPage> {
  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final provider = excursionProvider(_selectedDate);
    final excursionsAsync = ref.watch(provider);
    return Scaffold(
      appBar: AppBar(title: const Text('Мои экскурсии')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Calendar(
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = DateUtils.dateOnly(date);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            child: Text(
              formatDateTitle(_selectedDate),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: excursionsAsync.when(
              skipLoadingOnRefresh: false,
              data: (excursions) {
                if (excursions.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/empty_excursions.svg'),
                      const SizedBox(height: 30),
                      Text(
                        'На этот день экскурсий нет',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        ExcursionCard(excursion: excursions[index]),
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemCount: excursions.length,
                  ),
                );
              },
              error: (error, stackTrace) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/error.svg'),
                  const SizedBox(height: 35),
                  Text(
                    'Не удалось загрузить экскурсии',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      ref.invalidate(provider);
                    },
                    child: Text(
                      'Повторить',
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: AppColors.link),
                    ),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
