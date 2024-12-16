import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DividerSection extends StatelessWidget {
  const DividerSection({
    super.key,
    this.titleSection,
    this.routeOfSection,
    this.params,
    this.iconButton,
  });
  final String? titleSection;
  final String? routeOfSection;
  final Map<String, String>? params;
  final IconButton? iconButton;
  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.62,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: routeOfSection != null
                        ? () {
                            if (params != null) {
                              context.pushNamed(
                                routeOfSection!,
                                pathParameters: params!,
                              );
                              return;
                            }
                            context.pushNamed(
                              routeOfSection!,
                            );
                          }
                        : null,
                    label: Text(
                      titleSection ?? 'Nueva Sección',
                      style: title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    icon: const Icon(Icons.link),
                  ),
                ),
              ),
              if (iconButton != null) iconButton!,
            ],
          ),
          // const Divider(
          //   thickness: 1.2,
          // ),
        ],
      ),
    );
  }
}
