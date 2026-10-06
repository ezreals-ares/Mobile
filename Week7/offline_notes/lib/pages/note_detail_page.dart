import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/note_providers.dart';
import '../widgets/note_form_dialog.dart';

class NoteDetailPage extends ConsumerWidget {
  const NoteDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteAsync = ref.watch(noteByIdProvider(id));

    final note = noteAsync.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail catatan'),
        actions: [
          if (note != null)
            IconButton(
              tooltip: 'Ubah catatan',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () async {
                final result = await showDialog<NoteFormResult>(
                  context: context,
                  builder: (_) => NoteFormDialog(initial: note),
                );
                if (result == null) return; // dibatalkan
                await ref.read(noteActionsProvider).update(
                      note.copyWith(title: result.title, body: result.body),
                    );
              },
            ),
        ],
      ),
      body: noteAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Gagal membaca catatan: $e')),
        data: (note) {
          if (note == null) {
            return const Center(child: Text('Catatan tidak ditemukan'));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Diubah: ${note.updatedAt.toLocal()}'
                  '${note.dirty ? ' • belum tersinkron' : ''}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Divider(height: 24),
                Text(note.body.isEmpty ? '(tanpa isi)' : note.body),
              ],
            ),
          );
        },
      ),
    );
  }
}
