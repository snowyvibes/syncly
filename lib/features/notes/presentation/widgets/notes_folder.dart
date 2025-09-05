import 'package:flutter/material.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';
import 'package:syncly/features/notes/presentation/widgets/note_tile.dart';

class NotesFolder extends StatelessWidget {
  const NotesFolder({
    super.key,
    required this.folderName,
    required this.notes,
    this.folderIcon = Icons.folder,
  });

  final String folderName;
  final List<Note> notes;
  final IconData? folderIcon;

  @override
  Widget build(BuildContext context) {
    final controller = ExpansibleController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [ 
          // Inner shadow (light)
          BoxShadow(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.7),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          // Outer shadow (dark)
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : const Color(0xFF0D2750).withOpacity(0.16),
            offset: const Offset(4, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Expansible(
          controller: controller,
          headerBuilder: (context, animation) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                if (folderIcon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      folderIcon,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    folderName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${notes.length}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
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
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    if (notes.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: [
                            Icon(
                              Icons.folder_open_rounded,
                              size: 32,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant.withOpacity(0.5),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No notes in this folder',
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
                        itemCount: notes.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) => NoteTile(note: notes[index]),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:syncly/core/utils/constants.dart';
// import 'package:syncly/features/notes/domain/entities/note.dart';
// import 'package:syncly/features/notes/presentation/widgets/note_tile.dart';

// class NotesFolder extends StatelessWidget {
//   const NotesFolder({
//     super.key,
//     required this.folderName,
//     required this.notes,
//     this.folderIcon = Icons.folder,
//   });

//   final String folderName;
//   final List<Note> notes; // or whatever type your items are
//   final IconData? folderIcon;

//   @override
//   Widget build(BuildContext context) {
//     final controller = ExpansibleController();

//     return Card(
//       elevation: 5,
//       child: Expansible(
//         controller: controller,
//         headerBuilder: (context, animation) => Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

//           child: Row(
//             children: [
//               if (folderIcon != null) ...[
//                 Icon(
//                   folderIcon,
//                   color: Theme.of(context).colorScheme.onSurfaceVariant,
//                 ),
//                 const SizedBox(width: 12),
//               ],
//               Expanded(
//                 child: Text(
//                   folderName,
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Badge(
//                 label: Text('${notes.length}'),
//                 child: AnimatedRotation(
//                   turns: animation.value * 0.5,
//                   duration: const Duration(milliseconds: 200),
//                   child: IconButton(
//                     padding: EdgeInsets.zero,
//                     onPressed: () {
//                       print('Folder tapped: $folderName');
//                       print('Expanded: ${controller.isExpanded}');
//                       controller.isExpanded ? controller.collapse() : controller.expand();
//                     },
//                     icon: const Icon(Icons.keyboard_arrow_down),
//                     color: Theme.of(context).colorScheme.onSurfaceVariant,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         bodyBuilder: (context, animation) => FadeTransition(
//           opacity: animation,
//           child: SizeTransition(
//             sizeFactor: animation,
//             child: Container(
//               padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
//               child: Column(
//                 children: [
//                   const Divider(height: 1),
//                   kSizedBox,
//                   if (notes.isEmpty)
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       child: Text(
//                         'No items in this folder',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: Theme.of(context).colorScheme.onSurfaceVariant,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     )
//                   else
//                     ListView.separated(
//                       shrinkWrap: true,
//                       padding: EdgeInsets.zero,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: notes.length,
//                       separatorBuilder: (context, index) => kSizedBox,
//                       itemBuilder: (context, index) => NoteTile(note: notes[index]),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
