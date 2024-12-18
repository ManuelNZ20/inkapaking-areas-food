import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart';
import '../screens/screens.dart';

class ContainerListSaucerWithSchedule extends ConsumerStatefulWidget {
  const ContainerListSaucerWithSchedule({
    super.key,
    required this.scheduleId,
  });
  final int scheduleId;

  @override
  ContainerListSaucerWithScheduleState createState() =>
      ContainerListSaucerWithScheduleState();
}

class ContainerListSaucerWithScheduleState
    extends ConsumerState<ContainerListSaucerWithSchedule> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(saucersByScheduleProvider(widget.scheduleId).notifier).reset();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels + 100 >=
          scrollController.position.maxScrollExtent) {
        ref
            .read(
              saucersByScheduleProvider(widget.scheduleId).notifier,
            )
            .loadNextPage();
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
    final saucers = ref.watch(saucersByScheduleProvider(widget.scheduleId));
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.1,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: saucers.saucers.length,
        itemBuilder: (context, index) {
          final saucer = saucers.saucers[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SizedBox(
              width: size.width * .9,
              child: ListTile(
                title: Text(
                  saucer.nameSaucer,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  saucer.nameDrink,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: IconButton(
                  onPressed: () => context.pushNamed(
                    SaucerFormScreen.routeName,
                    pathParameters: {
                      'new_saucer_id': '${saucer.saucerId}',
                    },
                  ),
                  icon: const Icon(Icons.edit_note_outlined),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
