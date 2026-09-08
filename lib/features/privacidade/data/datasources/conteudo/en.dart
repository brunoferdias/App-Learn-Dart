import '../../../domain/entities/documento_legal.dart';

const DocumentoLegal documentoLegalEn = DocumentoLegal(
  atualizadoEm: 'September 7, 2026',
  contato: 'brudiasapp@outlook.com',
  resumo:
      'Learn Dart collects nothing, transmits nothing and sells nothing. '
      'Everything the app remembers stays on your device, and it is gone when '
      'you uninstall.',
  partes: [
    ParteLegal(
      titulo: 'Privacy Policy',
      clausulas: [
        ClausulaLegal(
          numero: 1,
          titulo: 'What the app collects',
          paragrafos: [
            '**Nothing.**',
            'The app asks for no account, no e-mail, no login, no phone '
                'number and no location. It does not access your contacts, '
                'photos, camera, microphone or calendar. There are no ads, no '
                'trackers, no analytics and no advertising identifier of any '
                'kind.',
            'The app opens no network connection of its own: all content — '
                'the lessons, the exercises, the glossary and the Dart '
                'interpreter — ships inside the app and works offline.',
          ],
        ),
        ClausulaLegal(
          numero: 2,
          titulo: 'What is stored on your device',
          paragrafos: [
            'So the app can remember where you left off, a few preferences '
                'are written to your device local storage '
                '(`SharedPreferences`, which on iOS is `NSUserDefaults`):',
          ],
          itens: [
            'the language you chose (Portuguese or English);',
            'the theme you chose (system, light or dark);',
            'whether you have already seen the intro;',
            'your study progress: which lessons you marked as completed, and '
                'how many right and wrong answers you gave in the exercises;',
            'counters used to decide whether and when the app may ask you, at '
                'most twice, to rate it on the App Store.',
          ],
        ),
        ClausulaLegal(
          numero: 3,
          titulo: 'None of this identifies you',
          paragrafos: [
            'There is no name, e-mail, number, nickname or device identifier '
                '— only counters, dates and preferences.',
            'This information is **not** sent to us or to anyone else. There '
                'is no Learn Dart server, no database of ours and no account '
                'for such data to go to.',
          ],
        ),
        ClausulaLegal(
          numero: 4,
          titulo: 'The code you write in the editor',
          paragrafos: [
            'The app Dart editor runs an interpreter written in Dart, inside '
                'the application itself. The code you type is processed only '
                'in your device memory. It is never stored on a server and '
                'never sent anywhere.',
          ],
        ),
        ClausulaLegal(
          numero: 5,
          titulo: 'Device backup',
          paragrafos: [
            'If you have iCloud Backup or local backup enabled, iOS may '
                'include the app preferences (item 2) in your device backup, '
                'along with those of every other app. That backup is made by '
                'Apple, under Apple privacy policy, and we have no access to '
                'it. You control this in your device settings.',
          ],
        ),
        ClausulaLegal(
          numero: 6,
          titulo: 'App Store reviews',
          paragrafos: [
            'At specific moments, and at most twice, the app may show the '
                'standard iOS review dialog (`SKStoreReviewController`). '
                'There is also a button on this tab so you can rate it '
                'whenever you want.',
            'That dialog belongs to Apple, not to us: we do not see the '
                'rating you give, we do not see what you write, and we '
                'receive no data because of it. If you tap the button and are '
                'taken to the App Store, Apple privacy policy and terms apply.',
          ],
        ),
        ClausulaLegal(
          numero: 7,
          titulo: 'Third-party services',
          paragrafos: [
            'The app uses no analytics, advertising, notification or cloud '
                'services. The only third-party components are open-source '
                'libraries that run locally and collect no data, among them '
                'the libraries used to store preferences on the device and to '
                'invoke the Apple review dialog.',
          ],
        ),
        ClausulaLegal(
          numero: 8,
          titulo: 'Children',
          paragrafos: [
            'Since the app collects no personal data from anyone, it collects '
                'no data from children either. There is no chat, no '
                'user-submitted content, no purchases and no advertising '
                'links.',
          ],
        ),
        ClausulaLegal(
          numero: 9,
          titulo: 'Deleting your data',
          paragrafos: [
            'The **Erase saved data** button, right here on this tab, removes '
                'the completed lessons and the right/wrong answer counts from '
                'your device. It is immediate and cannot be undone.',
            'Uninstalling the app erases everything it wrote on your device, '
                'including the language and theme preferences. There is '
                'nothing stored anywhere else to request the deletion of. '
                'Because we hold no data, we also have no way to identify you '
                'in order to answer access, correction or deletion requests — '
                'there is simply nothing to access.',
          ],
        ),
        ClausulaLegal(
          numero: 10,
          titulo: 'Your rights (GDPR and LGPD)',
          paragrafos: [
            'The GDPR and the Brazilian LGPD (Law 13.709/2018) govern the '
                'processing of personal data. Because Learn Dart carries out '
                'no processing of personal data — it does not collect, does '
                'not store anything off your device, does not share and does '
                'not transfer — there is no processing operation over which '
                'those rights could be exercised. Even so, if you have any '
                'question, write to the contact address at the top of this '
                'page.',
          ],
        ),
        ClausulaLegal(
          numero: 11,
          titulo: 'Changes to this policy',
          paragrafos: [
            'If this policy changes, the “last updated” date at the top '
                'changes with it, and the new version applies from '
                'publication. Should any future change involve collecting '
                'data, that will be stated here clearly and prominently '
                'before it happens.',
          ],
        ),
      ],
    ),
    ParteLegal(
      titulo: 'Terms of Use',
      clausulas: [
        ClausulaLegal(
          numero: 1,
          titulo: 'Acceptance',
          paragrafos: [
            'By installing or using Learn Dart, you agree to these Terms. If '
                'you do not agree, simply do not use the app and uninstall it.',
          ],
        ),
        ClausulaLegal(
          numero: 2,
          titulo: 'What the app is',
          paragrafos: [
            'Learn Dart is an independent educational app for learning the '
                'Dart programming language. It is free, works offline, has no '
                'ads, no in-app purchases and no subscription.',
          ],
        ),
        ClausulaLegal(
          numero: 3,
          titulo: 'Independent project — not affiliated with Google',
          paragrafos: [
            'This is an independent study project. It is **not** an official '
                'Google product and is not affiliated with, sponsored by, '
                'endorsed by or reviewed by Google LLC.',
            'Dart, Flutter and their logos are trademarks of Google LLC, used '
                'here only to refer descriptively to the language and the '
                'framework. The official language documentation lives at '
                '`dart.dev`.',
          ],
        ),
        ClausulaLegal(
          numero: 4,
          titulo: 'Educational content, not professional advice',
          paragrafos: [
            'The lessons, exercises, explanations and examples are study '
                'material, written with care but with no guarantee of being '
                'complete, current or free of error. Dart evolves, and the '
                'official documentation at `dart.dev` always takes precedence '
                'over anything written here.',
            'Do not rely on the app content as the sole basis for technical, '
                'professional or business decisions.',
          ],
        ),
        ClausulaLegal(
          numero: 5,
          titulo: 'The editor and its limits',
          paragrafos: [
            'The app editor is not the Dart compiler. A compiled application '
                'cannot compile Dart at runtime, so the editor ships its own '
                'interpreter, written in Dart, which runs a subset of the '
                'language: variables, types, null safety, functions, '
                'closures, loops, collections, classes, `try/catch` and '
                'several files talking to each other.',
            'It does not run `async/await`, inheritance, mixins or external '
                'packages. Code may therefore behave differently here and in '
                'real Dart. For the full language, use the official SDK or '
                'DartPad at `dartpad.dev`.',
          ],
        ),
        ClausulaLegal(
          numero: 6,
          titulo: 'Permitted use',
          paragrafos: [
            'You may use the app freely to study, including in a classroom, '
                'and you may use the code snippets from the examples in your '
                'own projects.',
            'You may not: redistribute the app as your own, sell it, remove '
                'the independent project notices, or use the app name or '
                'visual identity to suggest an affiliation, endorsement or '
                'partnership that does not exist.',
          ],
        ),
        ClausulaLegal(
          numero: 7,
          titulo: 'Intellectual property',
          paragrafos: [
            'The text of the lessons, exercises and glossary was written by '
                'the app developer. Third-party trademarks mentioned belong '
                'to their respective owners.',
          ],
        ),
        ClausulaLegal(
          numero: 8,
          titulo: 'No warranties',
          paragrafos: [
            'The app is provided “as is”, without warranty of any kind, '
                'express or implied, including warranties of fitness for a '
                'particular purpose, uninterrupted operation or freedom from '
                'error.',
          ],
        ),
        ClausulaLegal(
          numero: 9,
          titulo: 'Limitation of liability',
          paragrafos: [
            'To the fullest extent permitted by applicable law, the developer '
                'is not liable for any direct, indirect, incidental or '
                'consequential loss or damage arising from the use of, or '
                'inability to use, the app, including loss of data or losses '
                'tied to technical decisions made on the basis of the '
                'educational content.',
          ],
        ),
        ClausulaLegal(
          numero: 10,
          titulo: 'Availability and changes',
          paragrafos: [
            'The app may be updated, changed or discontinued at any time. '
                'Distribution is handled by the App Store, and availability '
                'also depends on Apple rules and services.',
          ],
        ),
        ClausulaLegal(
          numero: 11,
          titulo: 'Changes to these Terms',
          paragrafos: [
            'These Terms may change. The “last updated” date at the top '
                'indicates the version in force. Continuing to use the app '
                'after a change means accepting the new version.',
          ],
        ),
        ClausulaLegal(
          numero: 12,
          titulo: 'Governing law',
          paragrafos: [
            'These Terms are governed by the laws of the Federative Republic '
                'of Brazil, with the courts of the user domicile elected to '
                'settle any dispute.',
          ],
        ),
        ClausulaLegal(
          numero: 13,
          titulo: 'Contact',
          paragrafos: [
            'Questions about privacy or about these Terms: write to '
                '`brudiasapp@outlook.com`.',
          ],
        ),
      ],
    ),
  ],
);
