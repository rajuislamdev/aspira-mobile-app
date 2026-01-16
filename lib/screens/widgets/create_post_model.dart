import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePostModal extends StatelessWidget {
  const CreatePostModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF13B9A5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    elevation: 4,
                  ),
                  child: const Text("Post", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),

        // Inputs
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Title Input
                _InputField(label: "Post Title", hint: "Enter a catchy title...", maxLines: 1),
                const SizedBox(height: 16),
                // Category Dropdown
                _CategoryDropdown(),
                const SizedBox(height: 16),
                // Body Text Area
                _InputField(
                  label: "Content",
                  hint: "What is on your mind? Share your insights with the community...",
                  maxLines: 8,
                ),
              ],
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
    );
  }
}

/// ================= Input Field =================
class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;

  const _InputField({required this.label, required this.hint, this.maxLines = 1});

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
        TextField(
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
  String selectedCategory = "communication";

  final Map<String, String> categories = {
    "leadership": "Leadership & Management",
    "communication": "Communication Skills",
    "design": "UI/UX Design Systems",
    "growth": "Growth Mindset",
    "tech": "Technology Trends",
  };

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
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1E26),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<String>(
            value: selectedCategory,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            dropdownColor: const Color(0xFF1A1E26),
            underline: const SizedBox(),
            isExpanded: true,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            items: categories.entries
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e.key,
                    child: Row(
                      children: [
                        const Icon(Icons.school, color: Color(0xFF13B9A5)),
                        const SizedBox(width: 8),
                        Text(e.value),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => selectedCategory = value);
            },
          ),
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

/// ================= SHOW MODAL FUNCTION =================
