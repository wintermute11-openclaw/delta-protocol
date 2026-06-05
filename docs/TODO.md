# TODO

## Phasen
- [x] Phase 1: Spielerbewegung, Maus-Zielen, Kamera, Wände/Kollision
- [x] Phase 2: Waffen, Kugeln, Munition, Treffer
- [x] Phase 3: Gegner mit Patrouillen und Health
- [x] Phase 4: Sichtkegel, Line-of-Sight, Entdeckung, Chase/Attack
- [x] Phase 5: Alarm-System mit Normal / Verdacht / Alarm
- [x] Phase 6: Mission Silent Ledger mit Bürogebäude, Serverziel, Optionalziel und Dach-Exfil
- [x] Phase 7: Spieler-Health, Tod, Game Over, Neustart ab Checkpoint
- [x] Phase 8: Nachtsichtgerät und Nachtatmosphäre
- [x] Phase 9: Platzhalter-Sounds
- [ ] Phase 10: Bugfixing, README, Steuerung, Run-Anleitung, TODO aktualisieren

## Bekannte offene Punkte
- Finale Godot-Unterversion für die Entwicklung noch nicht festgelegt; Ziel bleibt Godot 4.x.
- Das HUD zeigt Mission, Alarm, Night Vision, Waffe, Health und Game Over jetzt funktional, aber noch nicht als finale UI.
- Art-, Audio- und UI-Assets sind vorerst Platzhalter.
- Prüfen, ob die manuell gepflegte Input-Map, Autoload-Konfiguration, Missionsobjekte, Audiodateien und die .tscn-Dateien in der verwendeten Godot-4.x-Version ohne Nacharbeit laden.
- Der MVP-Checkpoint ist absichtlich nur der Missionsstart; keine Zwischen-Checkpoints und keine Savegames.
- Der Nacht-/Nachtsicht-Look nutzt bewusst einfache ColorRect-Overlays statt finaler Shader- oder Lighting-Lösungen.
- Die Audio-Implementation nutzt globales Playback ohne Spatial Audio, Mixer-Presets oder finale Lautheitsabstimmung.
- Exfil-Zone schliesst die Mission aktuell direkt beim Betreten ab, sobald das Primärziel erledigt ist; bewusst simpel für das MVP.
- TODO bei Unsicherheiten bewusst klein halten und einfache Lösungen bevorzugen.
