mixin Pubspec {
  static final buildDate = DateTime.utc(2023, 3, 30, 9, 32, 42);

  static const name = 'example';

  static const description =
      "Que tal presentear seus filhos com jogos criados com muito amor e carinho por um pai preocupado em tornar a vida da família mais harmoniosa? Imagine só: seus filhos vão poder compartilhar o mesmo smartphone e se divertir juntos sem precisar brigar por ele o tempo todo. E o melhor de tudo? Você, como pai ou mãe, vai poder relaxar sabendo que seus pequenos estão se divertindo com segurança e sem causar dores de cabeça para você. Que tal experimentar esses jogos incríveis agora mesmo?.\n";

  static const versionFull = '1.0.0+3';

  static const version = '1.0.0';

  static const versionSmall = '1.0';

  static const versionMajor = 1;

  static const versionMinor = 0;

  static const versionPatch = 0;

  static const versionBuild = 3;

  static const versionPreRelease = '';

  static const versionIsPreRelease = false;

  static const homepage = 'https://github.com/DavBfr/flutter_about';

  static const environment = <dynamic, dynamic>{
    'sdk': '>=2.12.0 <3.0.0',
  };

  static const dependencies = <dynamic, dynamic>{
    'about': null,
    'cupertino_icons': null,
    'flutter': <dynamic, dynamic>{
      'sdk': 'flutter',
    },
  };

  static const devDependencies = <dynamic, dynamic>{
    'build_runner': null,
    'flutter_lints': null,
    'flutter_test': <dynamic, dynamic>{
      'sdk': 'flutter',
    },
    'pubspec_extract': null,
  };

  static const dependencyOverrides = <dynamic, dynamic>{
    'about': <dynamic, dynamic>{
      'path': '..',
    },
  };

  static const flutter = <dynamic, dynamic>{
    'uses-material-design': true,
    'assets': <dynamic>[
      'CHANGELOG.md',
      'CODE_OF_CONDUCT.md',
      'CONTRIBUTING.md',
      'LICENSE.md',
      'README.md',
    ],
  };

  static const builders = <dynamic, dynamic>{
    'about': null,
  };

  static const authors = <String>[
    'Vinícius Rubens Pedrinho <vrpedrinho@gmail.com>',
  ];

  static const authorsName = <String>[
    'Vinícius Rubens Pedrinho',
  ];

  static const authorsEmail = <String>[
    'dev.nfet.net@gmail.com',
  ];
}
