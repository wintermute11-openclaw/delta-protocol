# TODO

## Phasen
- [x] Phase 0: Projektstruktur, README, DESIGN, TODO, CHANGELOG
- [x] Phase 1: Spielerbewegung, Maus-Zielen, Kamera, Wände/Kollision
- [x] Phase 2: Waffen, Kugeln, Munition, Treffer
- [x] Phase 3: Gegner mit Patrouillen und Health
- [x] Phase 4: Sichtkegel, Line-of-Sight, Entdeckung, Chase/Attack
- [x] Phase 5: Alarm-System mit Normal / Verdacht / Alarm
- [x] Phase 6: Mission Silent Ledger mit Bürogebäude, Serverziel, Optionalziel und Dach-Exfil
- [x] Phase 7: Spieler-Health, Tod, Game Over, Neustart ab Checkpoint
- [x] Phase 8: Nachtsichtgerät und Nachtatmosphäre
- [x] Phase 9: Platzhalter-Sounds
- [x] Phase 10: Bugfixing, statische Konsistenzprüfung und Abschlussdokumentation

## Offene technische Punkte nach MVP-Abschluss
- Echte Godot-Laufzeitprüfung lokal durchführen
- Overlay dynamisch an Viewport-Grösse und UI-Skalierung anpassen
- Collision Layers und Masks sauberer trennen
- Guard-Navigation langfristig robuster gestalten
- Finalere Pixel-Art und konsistentere Umgebungsoptik erstellen
- Finale Soundeffekte statt Platzhalter-WAVs einsetzen
- HUD visuell überarbeiten und besser layouten
- Balancing für Guard-Sicht, Schaden, Feuer-Intervalle und Munition testen
- Eventuelle Godot-Syntax-, Import- oder Szenenfehler nach erstem Engine-Test beheben

## Bekannte MVP-Einschränkungen
- Godot ist auf dem Hermes-System nicht installiert; daher war nur statische Prüfung möglich.
- Das HUD ist funktional, aber noch keine finale UI.
- Art-, Audio- und UI-Assets sind weiterhin Platzhalter.
- Der MVP-Checkpoint bleibt absichtlich auf den Missionsstart beschränkt.
- Nachtsicht nutzt einen einfachen Overlay-Ansatz statt finalem Lighting.
- Audio nutzt globales Playback ohne Spatial Audio oder finale Lautheitsabstimmung.
- Exfil schliesst die Mission bewusst direkt ab, sobald das Primärziel erledigt ist.
