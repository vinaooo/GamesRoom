import 'package:flutter/material.dart';
import 'package:about/about.dart';
import 'pubspec.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aboutPage = AboutPage(
      values: {
        'version': Pubspec.version,
        'buildNumber': Pubspec.versionBuild.toString(),
        'year': DateTime.now().year.toString(),
        'author': Pubspec.authorsName.join(', '),
      },
      title: const Text('About'),
      //applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
      applicationDescription: const Text(
        Pubspec.description,
        textAlign: TextAlign.justify,
      ),
      applicationIcon: const FlutterLogo(size: 100),
      applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
      children: const <Widget>[
        MarkdownPageListTile(
          filename: 'README.md',
          title: Text('View Readme'),
          icon: Icon(Icons.all_inclusive),
        ),
        MarkdownPageListTile(
          filename: 'CHANGELOG.md',
          title: Text('View Changelog'),
          icon: Icon(Icons.view_list),
        ),
        MarkdownPageListTile(
          filename: 'LICENSE.md',
          title: Text('View License'),
          icon: Icon(Icons.description),
        ),
        MarkdownPageListTile(
          filename: 'CONTRIBUTING.md',
          title: Text('Contributing'),
          icon: Icon(Icons.share),
        ),
        // MarkdownPageListTile(
        //   filename: 'CODE_OF_CONDUCT.md',
        //   title: Text('Code of conduct'),
        //   icon: Icon(Icons.sentiment_satisfied),
        // ),
        LicensesPageListTile(
          title: Text('Open source Licenses'),
          icon: Icon(Icons.favorite),
        ),
      ],
    );

    return MaterialApp(
      title: 'Games Room',
      home: aboutPage,
      theme: ThemeData(),
      darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}
