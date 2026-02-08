import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleText('Terms of Service'),
              SizedBox(height: 8),
              _BodyText('Last updated: January 2026'),

              SizedBox(height: 24),
              _SectionTitle('1. Acceptance of Terms'),
              _BodyText(
                'By accessing or using Aspira, you agree to follow these Terms. '
                'If you do not agree, please do not use the app.',
              ),

              SizedBox(height: 16),
              _SectionTitle('2. Eligibility'),
              _BodyText(
                'You must be at least 13 years old to use Aspira. '
                'If you are under 18, you confirm that you have permission from a parent or guardian.',
              ),

              SizedBox(height: 16),
              _SectionTitle('3. Your Account'),
              _BulletPoint('Keep your login details secure'),
              _BulletPoint('Provide accurate information'),
              _BulletPoint(
                'You are responsible for all activity under your account',
              ),

              SizedBox(height: 16),
              _SectionTitle('4. User Content'),
              _BodyText(
                'You may create or share content such as posts, comments, or reactions. '
                'You are responsible for the content you share.',
              ),

              SizedBox(height: 16),
              _SectionTitle('5. Prohibited Activities'),
              _BulletPoint('No abusive or harmful content'),
              _BulletPoint('No impersonation or harassment'),
              _BulletPoint('No illegal activities or hacking attempts'),

              SizedBox(height: 16),
              _SectionTitle('6. Intellectual Property'),
              _BodyText(
                'All app content, design, and branding belong to Aspira unless stated otherwise.',
              ),

              SizedBox(height: 16),
              _SectionTitle('7. Privacy'),
              _BodyText(
                'Your privacy matters to us. Please review our Privacy Policy to understand '
                'how we collect and use your data.',
              ),

              SizedBox(height: 16),
              _SectionTitle('8. Service Availability'),
              _BodyText(
                'We do not guarantee uninterrupted access and may update or discontinue '
                'features at any time.',
              ),

              SizedBox(height: 16),
              _SectionTitle('9. Limitation of Liability'),
              _BodyText(
                'Aspira is provided “as is.” We are not responsible for damages resulting '
                'from the use of the app.',
              ),

              SizedBox(height: 16),
              _SectionTitle('10. Termination'),
              _BodyText(
                'We may suspend or terminate your account if these terms are violated.',
              ),

              SizedBox(height: 16),
              _SectionTitle('11. Changes to Terms'),
              _BodyText(
                'We may update these Terms from time to time. Continued use means you accept the updates.',
              ),

              SizedBox(height: 16),
              _SectionTitle('12. Contact Us'),
              _BodyText('Email: support@aspira.app'),

              SizedBox(height: 32),
              Center(
                child: Text(
                  'Thank you for being part of Aspira 🌱',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;
  const _TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _BodyText extends StatelessWidget {
  final String text;
  const _BodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
