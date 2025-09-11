import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncly/core/utils/constants.dart';
import 'package:syncly/core/utils/sizes.dart';

class CustomExpansibleWidget extends StatefulWidget {
  const CustomExpansibleWidget({
    super.key,
    required this.items,
    required this.header,
    this.iconColor,
    this.initiallyExpanded = false,
  });

  final List<Widget> items;
  final Widget header;
  final bool initiallyExpanded;
  final IconData? emptyIcon = FontAwesomeIcons.folderOpen;
  final Color? iconColor;
  final String? emptyText = 'No items available';

  @override
  State<CustomExpansibleWidget> createState() => _CustomExpansibleWidgetState();
}

class _CustomExpansibleWidgetState extends State<CustomExpansibleWidget> {
  final controller = ExpansibleController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.initiallyExpanded) {
      controller.expand();
    }
  }

  @override
  Widget build(BuildContext context) => Expansible(
    controller: controller,

    headerBuilder: (context, animation) => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding * 1.5,
        vertical: AppSizes.padding,
      ),
      child: Row(
        spacing: AppSizes.rowSpacing,
        children: [
          Expanded(child: widget.header),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            ),
            child: AnimatedRotation(
              turns: animation.value * 0.5,
              duration: const Duration(milliseconds: 300),
              child: IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  controller.isExpanded ? controller.collapse() : controller.expand();
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  weight: 30,
                  color: widget.iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    bodyBuilder: (context, animation) => FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: Container(
          padding: const EdgeInsets.only(
            left: AppSizes.padding,
            right: AppSizes.padding,
            bottom: AppSizes.padding,
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          // padding: const EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 1,
                margin: const EdgeInsets.only(bottom: AppSizes.padding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(0, 153, 114, 114),
                      Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              if (widget.items.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.padding * 2),
                  child: Column(
                    children: [
                      Icon(
                        widget.emptyIcon,
                        size: 32,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withOpacity(0.5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.emptyText!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.items.length,
                  separatorBuilder: (context, index) => kSizedBox,
                  itemBuilder: (context, index) => widget.items[index],
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
