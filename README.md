# Delta Protocol: Operation Silent Ledger

Delta Protocol: Operation Silent Ledger ist ein spielbares MVP eines 2D-Top-Down-Stealth-Action-Spiels in Godot 4.x. Der Fokus liegt auf einer einzigen kompakten Black-Ops-Mission: nachts in das KRONOS-Finanzgebäude eindringen, Serverdaten kopieren, optional LEDGER-7 sichern und über das Dach exfiltrieren.

## MVP-Status
Der strukturelle MVP-Umfang ist implementiert und statisch geprüft. Eine echte Laufzeitprüfung in Godot konnte auf diesem Hermes-System nicht durchgeführt werden, weil keine Godot-Installation verfügbar ist.

## Godot-Version
Godot 4.x

## Projekt starten
1. Godot 4.x öffnen.
2. Import wählen.
3. /home/claw/delta_protocol/project.godot auswählen.
4. Projekt importieren.
5. Entweder das Projekt per Play starten oder direkt scenes/main/Main.tscn ausführen.

## Steuerung
- WASD oder Pfeiltasten: Bewegung
- Shift oder Ctrl: langsam / schleichend bewegen
- Maus: Zielen
- Linksklick: Schiessen / Angriff
- 1: MP5SD
- 2: Beretta M9
- 3: Messer
- E: Interagieren
- N: Nachtsicht umschalten
- R: Nach Tod Mission vom Start-Checkpoint neu laden

## Missionsziele
- Primärziel: Serverdaten im KRONOS-Serverraum kopieren
- Optionalziel: LEDGER-7 im Sicherheitsbüro sichern
- Exfil: Dach-Exfil-Zone erreichen

## Gameplay-Systeme im MVP
- Stealth-Grundgerüst mit Sichtkegeln und verdeckter Infiltration
- Guard-Sichtprüfung mit Line-of-Sight gegen Wände
- Alarm-System mit NORMAL, SUSPICIOUS und ALARM
- Waffenwechsel zwischen MP5SD, Beretta M9 und Messer
- Player-Health, Tod, Game-Over und Neustart ab Missionsstart
- Nachtsicht per Overlay-Toggle
- Platzhalter-Audio für Schüsse, Treffer, Alarm und Interaktion
- HUD mit Objective-, Alarm-, Health-, Weapon- und Night-Vision-Anzeige

## Missionsablauf im MVP
1. Über den Hintereingang starten.
2. Den Serverraum erreichen.
3. KRONOS-Daten kopieren.
4. Optional LEDGER-7 sichern.
5. Das Dach erreichen und exfiltrieren.

## Aktueller Feature-Stand nach Phasen
- Phase 0: Projektstruktur, Grunddateien und Basisdokumentation
- Phase 1: Bewegung, Kamera, Kollisionen
- Phase 2: Waffen, Kugeln, Munition, Messer, Treffer
- Phase 3: Patrouillierende Guards mit Health
- Phase 4: Sichtkegel, Entdeckung, Chase und Attack
- Phase 5: Globales Alarm-System
- Phase 6: Mission Silent Ledger mit Zielen und Exfil
- Phase 7: Health, Death, Game Over, Restart
- Phase 8: Nachtatmosphäre und Nachtsicht
- Phase 9: Platzhalter-Audio
- Phase 10: Abschlussdokumentation, statische Konsistenzprüfung und kleine Robustheitsprüfung

## Bekannte Einschränkungen
- Keine Laufzeitprüfung in Godot auf dem Hermes-System
- Keine visuelle Prüfung der Szenen auf diesem System
- Keine Importprüfung der WAV-Dateien in der Engine auf diesem System
- Platzhaltergrafik statt finaler Pixel-Art
- Platzhaltersounds statt finaler Soundeffekte
- Einfache Guard-KI ohne Deckung, Verstärkung oder Leichenentdeckung
- Simples Nachtsicht-Overlay statt finalem Lighting- oder Shader-System
- Kein Save-System
- Checkpoint nur am Missionsstart
- Collision Layers und Navigation sind noch bewusst simpel gehalten

## Wichtige Projektdateien
- project.godot
- scenes/main/Main.tscn
- scenes/levels/SilentLedger.tscn
- scenes/player/Player.tscn
- scenes/enemies/Guard.tscn
- scenes/ui/HUD.tscn
- scripts/autoload/game_state.gd
- scripts/autoload/audio_manager.gd
- scripts/mission/mission_manager.gd

## Weiterer manueller Test in Godot
Eine konkrete Checkliste für den ersten lokalen Engine-Test steht in docs/TESTING.md.
