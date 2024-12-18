import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';

class RadioListsSaucers extends ConsumerStatefulWidget {
  const RadioListsSaucers({
    super.key,
    required this.saucers,
    required this.scheduleId,
    required this.onChanged,
    required this.loadNextPage,
    required this.value,
  });
  final List<Saucer> saucers;
  final int scheduleId;
  final ValueChanged<int?>? onChanged;
  final VoidCallback? loadNextPage;
  final int value;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RadioListSaucerState();
}

class _RadioListSaucerState extends ConsumerState<RadioListsSaucers> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollController.position.pixels + 120 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saucers = widget.saucers;
    final groupValue = widget.value;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.1,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: saucers.length,
        itemBuilder: (context, index) {
          final saucer = saucers[index];
          return Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: SizedBox(
              width: size.width * .9,
              child: RadioListTile(
                title: Text(saucer.nameSaucer),
                subtitle: Text(saucer.nameDrink),
                value: saucer.saucerId,
                groupValue: groupValue,
                onChanged: widget.onChanged,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
