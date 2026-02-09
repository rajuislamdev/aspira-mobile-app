import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/utils/ui_support.dart';
import 'package:aspira/view_models/auth/update_profile_view_model.dart';
import 'package:aspira/view_models/profile/fetch_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late TextEditingController _jobPositionController;

  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _emailController = TextEditingController();
    _bioController = TextEditingController();
    _jobPositionController = TextEditingController();
    _focusNodes = List.generate(5, (_) => FocusNode());
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _emailController.dispose();
    _bioController.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF111214),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          title: Text(
            'Profile Information',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer(
          builder: (context, ref, child) {
            ref.listen(updateProfileViewModelProvider, (previous, next) {
              if (next is AsyncData) {
                final message = next.value;
                if (message != null && message.isNotEmpty) {
                  ref
                      .read(fetchProfileViewModelProvider.notifier)
                      .fetchProfile();
                  Ui.showSuccessSnackBar(context, message: message);
                }
              } else if (next is AsyncError) {
                final message = next.error is Failure
                    ? (next.error as Failure).message
                    : next.error.toString();
                Ui.showErrorSnackBar(context, message: message);
              }
            });
            final viewModel = ref.watch(fetchProfileViewModelProvider);
            return viewModel.when(
              data: (data) {
                _firstName.text = data?.firstName ?? '';
                _lastName.text = data?.lastName ?? '';
                _emailController.text = data?.email ?? '';
                _jobPositionController.text = data?.position ?? '';
                _bioController.text = data?.bio ?? '';
                return SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                        child: Column(
                          children: [
                            /// ================= PROFILE IMAGE =================
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 48,
                                  backgroundColor: const Color(0xFF1E293B),
                                  child: const Icon(
                                    Icons.person,
                                    size: 48,
                                    color: Colors.white70,
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF14B8A6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 18,
                                      color: Color(0xFF111214),
                                    ),
                                    onPressed: () {
                                      // TODO: pick image
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            /// ================= NAME =================
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: _InputField(
                                    focusNode: _focusNodes[0],
                                    label: 'First Name',
                                    hint: 'First name',
                                    controller: _firstName,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Flexible(
                                  flex: 1,
                                  child: _InputField(
                                    focusNode: _focusNodes[1],
                                    label: 'Last Name',
                                    hint: 'Last name',
                                    controller: _lastName,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            /// ================= EMAIL =================
                            _InputField(
                              focusNode: _focusNodes[2],
                              label: 'Job Position',
                              hint: 'Your job position',
                              controller: _jobPositionController,
                              enabled:
                                  true, // usually job position is not editable
                            ),

                            const SizedBox(height: 16),
                            _InputField(
                              focusNode: _focusNodes[3],
                              label: 'Email Address',
                              hint: 'you@example.com',
                              controller: _emailController,
                              enabled: false, // usually email is not editable
                              readOnly: true,
                            ),

                            const SizedBox(height: 16),

                            /// ================= BIO =================
                            _InputField(
                              focusNode: _focusNodes[4],
                              label: 'Bio',
                              hint: 'Tell us about yourself',
                              controller: _bioController,
                              maxLines: 4,
                            ),

                            const SizedBox(height: 32),

                            /// ================= UPDATE BUTTON =================
                            Consumer(
                              builder: (context, ref, child) {
                                ref.listen(updateProfileViewModelProvider, (
                                  _,
                                  next,
                                ) {
                                  next.whenOrNull(
                                    data: (message) {
                                      if (message != null &&
                                          message.isNotEmpty) {
                                        ref
                                            .read(
                                              fetchProfileViewModelProvider
                                                  .notifier,
                                            )
                                            .fetchProfile();
                                      }
                                    },
                                  );
                                });
                                final updateState = ref.watch(
                                  updateProfileViewModelProvider,
                                );
                                return SizedBox(
                                  height: 52,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF14B8A6),
                                      foregroundColor: const Color(0xFF111214),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    onPressed: updateState.isLoading
                                        ? null
                                        : () {
                                            final payload = <String, dynamic>{};
                                            final firstName = _firstName.text
                                                .trim();
                                            final lastName = _lastName.text
                                                .trim();
                                            final position =
                                                _jobPositionController.text
                                                    .trim();
                                            final bio = _bioController.text
                                                .trim();

                                            if (firstName.isNotEmpty) {
                                              payload['firstName'] = firstName;
                                            }
                                            if (lastName.isNotEmpty) {
                                              payload['lastName'] = lastName;
                                            }
                                            if (position.isNotEmpty) {
                                              payload['position'] = position;
                                            }
                                            if (bio.isNotEmpty) {
                                              payload['bio'] = bio;
                                            }

                                            if (payload.isEmpty) {
                                              Ui.showErrorSnackBar(
                                                context,
                                                message:
                                                    'Please update at least one field',
                                              );
                                              return;
                                            }

                                            ref
                                                .read(
                                                  updateProfileViewModelProvider
                                                      .notifier,
                                                )
                                                .updateProfile(
                                                  payload: payload,
                                                );
                                          },
                                    child: updateState.isLoading
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Color(0xFF111214),
                                            ),
                                          )
                                        : Text(
                                            'Update Profile',
                                            style: GoogleFonts.manrope(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 16),

                            Text(
                              'You can update your information anytime.',
                              style: GoogleFonts.manrope(
                                fontSize: 13,
                                color: const Color(0xFFB8B9BD),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              loading: () => SizedBox.shrink(),
              error: (error, s) => SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}

/// ================= INPUT FIELD =================

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool enabled;
  final int maxLines;
  final FocusNode focusNode;
  final bool readOnly;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    this.enabled = true,
    this.maxLines = 1,
    this.readOnly = false,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFB8B9BD),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          readOnly: readOnly,
          focusNode: focusNode,
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          style: GoogleFonts.manrope(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF171A29),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
