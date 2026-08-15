# AceIt — Interview Prep Flashcards (Flutter, UI-only)

A flashcard-based interview prep app UI: Frontend / Backend / Database /
DevOps / System Design tracks, each with topics, each topic with flip-style
flashcards. **This build has no backend** — no Firebase, no networking, no
persistence. All content lives in one in-memory seed file and resets when
the app restarts.

## Project structure

```
lib/
  theme/                 # colors + Material theme
  core/
    constants/            # icon-key -> IconData mapping
    widgets/               # generic shared widgets (button, progress bar)
  models/                 # plain Dart data classes (Track, Topic, Flashcard, UserStats)
  data/
    mock_data.dart          # the ONLY file with hardcoded content — seed tracks/topics/cards
  providers/               # ChangeNotifier state for each screen, reading/writing MockData in memory
  screens/
    home/
    track/
    study/
    add_flashcard/
  widgets/                 # screen-specific widgets (flip card, topic row, track card...)
  main.dart
```

No `domain`/`data-source` split, no repository interfaces, no dependency
injection container — none of that is needed without a backend to abstract
over. Providers talk to `MockData` directly, which keeps every file small
and easy to follow.

## Run it

```bash
flutter pub get
flutter run
```

That's it — no API keys, no config files, no `flutterfire configure`.

## Where the content lives

Everything shown in the app — the 5 tracks, their topics, progress
percentages, and the REST API flashcards — is defined in
`lib/data/mock_data.dart`. Add more flashcards there (or through the in-app
**Add Flashcard** screen, which appends to the same in-memory list) to see
more topics fill out.

## Flip card animation

`lib/widgets/flip_flashcard.dart` drives the question/answer flip:
- A 3D Y-axis rotation with perspective (`Matrix4.rotateY` + `setEntry`)
  swaps between the question and answer face.
- A subtle scale "pop" at the midpoint makes the card feel like it lifts
  off the stack as it turns, rather than rotating flat.
- Two static offset cards sit behind the flipping one for a stacked-deck
  look, and settle slightly once the flip finishes.
- The active face carries a faint topic-icon watermark in the corner and
  an icon inside the Question/Answer badge (bulb for question, check for
  answer) that switches with the label.

## What's here vs. not wired

| Feature | Status |
|---|---|
| Home (tracks, streak, stats, Continue Learning) | Built, from mock data |
| Track → Topics list + Progress tab | Built, from mock data |
| Study flow (flip card, next/prev, show/hide answer, bookmark, delete) | Built, in-memory |
| Add Flashcard (track/topic pick, question/answer, save) | Built, appends in-memory |
| Study / Progress / Profile bottom-nav tabs | Placeholder — only Home was in the provided designs |
| Any backend, auth, or persistence | Intentionally not included |
