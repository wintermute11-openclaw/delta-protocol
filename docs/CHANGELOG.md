# Changelog

## [Phase 7] - 2026-06-05
- Player-Tod mit `player_died`- und `health_changed`-Signalen finalisiert.
- Angriff, Bewegung und Waffenhandling werden nach Tod sauber deaktiviert.
- Restart per R über `reload_current_scene()` ergänzt; Missionsstart dient als einfacher Checkpoint.
- HUD um Game-Over-Overlay mit "MISSION FAILED" und Restart-Hinweis erweitert.
- Exfil-Zone prüft jetzt defensiv, dass nur ein lebender Player die Mission abschliessen kann.

## [Phase 6] - 2026-06-05
- MissionManager für Primärziel, Optionalziel, Exfil-Freigabe und Missionsabschluss ergänzt.
- Interaktionsobjekte für Server-Terminal, LEDGER-7-Akte und Exfil-Zone als Area2D-Szenen erstellt.
- Neues Missionslevel `SilentLedger.tscn` mit Hintereingang, Empfang, Grossraumbüro, Sicherheitsbüro, Serverraum, Treppenhaus und Dach-Exfil aufgebaut.
- HUD um Missionsstatus, Optionalziel-Status und Missionsabschluss-Anzeige erweitert.
- Main-Szene auf das neue Missionslevel umgestellt und Dokumentation für Phase 6 aktualisiert.

## [Phase 5] - 2026-06-05
- Globales GameState-Autoload mit Alarmzuständen NORMAL, SUSPICIOUS und ALARM ergänzt.
- Guards melden Sichtkontakt jetzt an das globale Alarm-System und nutzen globale letzte Spielerpositionen als Suchziel.
- Laute Schüsse der Beretta M9 lösen Alarm aus; MP5SD und Messer bleiben akustisch leise.
- Kleines HUD mit Alarmstatus sowie Debug-Anzeige für Waffe und Health ergänzt.
- README, TODO und Design-Dokumentation für den Phase-5-Stand aktualisiert.

## [Phase 4] - 2026-06-05
- Player um einfache Schadens- und Dead-Logik erweitert, damit Guards angreifen können.
- Guard-KI um Sichtkegel, Line-of-Sight-Raycast, SUSPICIOUS, CHASE und ATTACK erweitert.
- Guards verfolgen den Spieler jetzt lokal pro Instanz, ohne globales Alarm-System.
- Halbtransparenter VisionCone als Debug-Darstellung für Guard-Sicht ergänzt.
- README, TODO und Design-Dokumentation für den Phase-4-Stand aktualisiert.

## [Phase 3] - 2026-06-05
- Guard-Szene und Guard-State-Machine mit vorbereiteten Zuständen PATROL, SUSPICIOUS, CHASE, ATTACK und DEAD ergänzt.
- In Phase 3 werden nur PATROL und DEAD aktiv genutzt; spätere Zustände sind im Code markiert.
- Guards erhalten Health, `take_damage(amount)` und wechseln bei 0 Health in einen deaktivierten DEAD-Zustand.
- Main-Szene um zwei patrouillierende Guard-Instanzen mit festen Wegpunktrouten erweitert.
- README, TODO und Design-Hinweise für den Phase-3-Stand aktualisiert.

## [Phase 2] - 2026-06-05
- Input-Map um Feuer- und Waffenwechsel-Actions erweitert.
- Bullet-Szene und Bullet-Skript für Projektilbewegung, Lebenszeit und defensive Trefferlogik erstellt.
- Einfache WeaponData-Struktur mit Slots, Schaden, Munition, Fire-Rate und Loud-Flag ergänzt.
- Player um Waffenwechsel, Schussangriffe und kurzen Messer-Nahkampfangriff erweitert.
- DummyTarget-Testszene mit `take_damage(amount)` für Kampftests ergänzt.
- Main-Szene um mehrere DummyTargets als statische Trefferziele erweitert.
- README und TODO für den neuen Phase-2-Status aktualisiert.

## [Phase 1] - 2026-06-05
- Eingabe-Actions für Bewegung und langsames Schleichen im Projekt angelegt.
- Player-Szene als CharacterBody2D mit Maus-Ausrichtung, normaler und langsamer Bewegung erstellt.
- Camera2D am Spieler ergänzt, damit die Kamera dem Operator folgt.
- Main-Szene zu einem einfachen Testlevel mit Bodenfläche und mehreren kollidierenden Wänden ausgebaut.
- README und TODO für den neuen Projektstatus aktualisiert.

## [Phase 0] - 2026-06-05
- Git-Repository für das Projekt initialisiert.
- Zielstruktur für Szenen, Skripte, Assets und Dokumentation angelegt.
- README.md mit Projektziel, Steuerung und aktuellem Status erstellt.
- docs/DESIGN.md mit Spielkonzept, Mission, Kernmechaniken und MVP-Abgrenzung erstellt.
- docs/TODO.md mit Phasenplan und offenen Punkten erstellt.
- Minimale Godot-Grunddateien für Projekt und Hauptszene angelegt.
