import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/utils/app_constants.dart';
import 'package:aspira/core/utils/ui_support.dart';
import 'package:aspira/models/profile_model/interest.dart';
import 'package:aspira/view_models/post/create_post_view_model.dart';
import 'package:aspira/view_models/profile/fetch_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePostModal extends ConsumerStatefulWidget {
  const CreatePostModal({super.key});

  @override
  ConsumerState<CreatePostModal> createState() => _CreatePostModalState();
}

class _CreatePostModalState extends ConsumerState<CreatePostModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final bool _showValidationError = false;

  @override
  initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (ref.read(selectedInterestProvider) == null) {
        Ui.showErrorSnackBar(context, message: "Please select an interest");
      }
      final payload = {
        'content': _contentController.text.trim(),
        'title': _titleController.text.trim(),
        'interestId': ref
            .read(selectedInterestProvider)
            ?.id, // Replace with actual selected interest ID
      };

      ref.read(createPostViewModelProvider.notifier).createPost(payload: payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111317),
      body: Column(
        children: [
          SizedBox(height: 26),
          // Top AppBar
          SafeArea(
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF111317).withOpacity(0.95),
                border: const Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "Create Post",
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      ref.listen(createPostViewModelProvider, (_, next) {
                        next.whenOrNull(
                          data: (message) {
                            if (message != null) {
                              ref.read(selectedInterestProvider.notifier).update((state) => null);
                              Ui.showSuccessSnackBar(context, message: message);
                              Future.delayed(AppConstants.switchAnimationDuration, () {
                                Navigator.of(context).pop();
                              });
                            }
                          },

                          error: (error, s) {
                            final message = error is Failure
                                ? error.message
                                : "Something went wrong";
                            Ui.showErrorSnackBar(context, message: message);
                          },
                        );
                      });

                      final createPostViewModel = ref.watch(createPostViewModelProvider);
                      if (createPostViewModel.isLoading) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF13B9A5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          elevation: 4,
                        ),
                        child: const Text(
                          "Post",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Inputs
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Title Input
                    _InputField(
                      label: "Post Title",
                      hint: "Enter a catchy title...",
                      maxLines: 1,
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Category Dropdown
                    _CategoryDropdown(),
                    const SizedBox(height: 16),
                    // Body Text Area
                    _InputField(
                      label: "Content",
                      hint: "What is on your mind? Share your insights with the community...",
                      maxLines: 8,
                      controller: _contentController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Content cannot be empty';
                        }
                        return null;
                      },
                    ),
                    if (_showValidationError)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'Please fill in all required fields.',
                          style: TextStyle(color: Colors.red.shade300, fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Media Toolbar
          Container(
            margin: const EdgeInsets.only(bottom: 70, left: 16, right: 16),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF1A1E26),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _MediaButton(icon: Icons.image, label: "Image"),
                _MediaButton(icon: Icons.videocam, label: "Video"),
                _MediaButton(icon: Icons.mic, label: "Audio"),
                _MediaButton(icon: Icons.link, label: "Link"),
                VerticalDivider(width: 1, thickness: 1, color: Colors.grey),
                _MediaButton(icon: Icons.palette, label: "Style"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= Input Field =================
class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const _InputField({
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: const Color(0xFF1A1E26),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

/// ================= Category Dropdown =================
class _CategoryDropdown extends StatefulWidget {
  const _CategoryDropdown();

  @override
  State<_CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<_CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Learning Category".toUpperCase(),
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Consumer(
          builder: (context, ref, child) {
            ref.listen(fetchProfileViewModelProvider, (_, next) {
              next.whenOrNull(
                data: (profile) {
                  final selectedInterest = ref.read(selectedInterestProvider);
                  if (selectedInterest == null &&
                      profile?.interests != null &&
                      profile!.interests!.isNotEmpty) {
                    ref.read(selectedInterestProvider.notifier).state = profile.interests!.first;
                  }
                },
              );
            });
            final viewModel = ref.watch(fetchProfileViewModelProvider);
            return viewModel.when(
              data: (profile) => Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1E26),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<Interest>(
                  value: ref.watch(selectedInterestProvider),
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  dropdownColor: const Color(0xFF1A1E26),
                  underline: const SizedBox(),
                  hint: const Text(
                    "Choose Interest",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  items: profile?.interests!
                      .map(
                        (e) => DropdownMenuItem<Interest>(
                          value: e,
                          child: Row(
                            children: [
                              const Icon(Icons.school, color: Color(0xFF13B9A5)),
                              const SizedBox(width: 8),
                              Text(e.name ?? ''),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(selectedInterestProvider.notifier).state = value;
                    }
                  },
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (error, stackTrace) => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }
}

/// ================= Media Button =================
class _MediaButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MediaButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey, size: 28),
        const SizedBox(height: 2),
        Text(
          label.toUpperCase(),
          style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

final selectedInterestProvider = StateProvider<Interest?>((ref) => null);
