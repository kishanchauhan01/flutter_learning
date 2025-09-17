// lib/app/modules/home/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'widgets/note_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'My Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          Obx(() => controller.hasNotes
              ? IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: controller.onRefresh,
                  tooltip: 'Refresh',
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        // Loading state
        if (controller.isLoading && controller.notes.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading notes...'),
              ],
            ),
          );
        }

        // Empty state
        if (controller.notes.isEmpty) {
          return _buildEmptyState();
        }

        // Notes list
        return RefreshIndicator(
          onRefresh: controller.onRefresh,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              final note = controller.notes[index];
              return NoteCard(note: note);
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.showAddNoteBottomSheet,
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_add,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Notes Yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to create your first note',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: controller.showAddNoteBottomSheet,
            icon: const Icon(Icons.add),
            label: const Text('Create First Note'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}