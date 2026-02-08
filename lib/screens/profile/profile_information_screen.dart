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

  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _emailController = TextEditingController();
    _bioController = TextEditingController();
    _focusNodes = List.generate(4, (_) => FocusNode());
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
        backgroundColor: const Color(0xFF111214),
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
            final viewModel = ref.watch(fetchProfileViewModelProvider);
            return viewModel.when(
              data: (data) {
                _firstName.text = data?.firstName ?? '';
                _lastName.text = data?.lastName ?? '';
                _emailController.text = data?.email ?? '';
                _bioController.text =
                    'Curious learner. Exploring tech. leadership & growth';
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
                              label: 'Email Address',
                              hint: 'you@example.com',
                              controller: _emailController,
                              enabled: false, // usually email is not editable
                            ),

                            const SizedBox(height: 16),

                            /// ================= BIO =================
                            _InputField(
                              focusNode: _focusNodes[3],
                              label: 'Bio',
                              hint: 'Tell us about yourself',
                              controller: _bioController,
                              maxLines: 4,
                            ),

                            const SizedBox(height: 32),

                            /// ================= UPDATE BUTTON =================
                            SizedBox(
                              height: 56,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF14B8A6),
                                  foregroundColor: const Color(0xFF111214),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  // TODO: call update profile API
                                },
                                child: Text(
                                  'Update Profile',
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    this.enabled = true,
    this.maxLines = 1,
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
