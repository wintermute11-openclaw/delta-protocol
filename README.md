# Delta Protocol: Operation Silent Ledger

Ein spielbares MVP eines 2D-Top-Down-Stealth-Action-Spiels in Godot 4.x mit Black-Ops-Militärthriller-Feeling der späten 80er/frühen 90er.

## MVP-Ziel
Ein einzelner spielbarer Infiltrationseinsatz in einem Bürogebäude bei Nacht: Daten vom KRONOS-Server kopieren, optional LEDGER-7 sichern und über das Dach exfiltrieren.

## Benötigte Godot-Version
Godot 4.x

## Steuerung
- WASD oder Pfeiltasten: Bewegung
- Maus: Zielen / Ausrichtung des Operators
- Linke Maustaste: Angriff / Schuss
- 1: MP5SD auswählen
- 2: Beretta M9 auswählen
- 3: Messer auswählen
- E: Interagieren mit Server, LEDGER-7 und Missionsobjekten
- Shift oder Ctrl: langsamer / schleichend bewegen
- N: Nachtsicht umschalten
- R: Nach Tod Mission vom Start-Checkpoint neu laden

## Projekt in Godot starten
1. Godot 4.x öffnen.
2. Import wählen.
3. /home/claw/delta_protocol/project.godot auswählen.
4. Projekt starten oder direkt die Hauptszene `scenes/main/Main.tscn` ausführen.

## Alarm-Verhalten im aktuellen MVP
- Alarmstatus kennt drei Zustände: NORMAL, SUSPICIOUS, ALARM.
- Beretta M9 löst globalen Alarm durch Schussgeräusch aus.
- MP5SD löst durch Sound keinen Alarm aus.
- Sichtkontakt eines Guards mit dem Player löst globalen Alarm aus.
- Guards können auf globalen Alarm reagieren und zur letzten bekannten Spielerposition suchen.

## Mission: Operation Silent Ledger
- Startpunkt: Hintereingang
- Primärziel: KRONOS-Server im Serverraum benutzen und Daten kopieren
- Optionalziel: LEDGER-7 im Sicherheitsbüro sichern
- Exfil: Dach-Exfil-Zone erreichen
- Missionserfolg: Primärziel abschliessen und danach die Exfil-Zone betreten

## Health, Death und Restart
- Der Player hat 3 Health.
- Guards verursachen Schaden, bis der Player fällt.
- Bei 0 Health erscheint "MISSION FAILED".
- Mit R wird die aktuelle Mission vom Start-Checkpoint neu geladen.
- Der MVP-Checkpoint ist nur der Missionsstart; es gibt keine Zwischen-Checkpoints und keine Savegames.

## Nachtatmosphäre und Nachtsicht
- Die Mission startet immer in einem dunklen Nachtmodus.
- Ein dunkles HUD-Overlay erzeugt die Grund-Nachtstimmung.
- Mit N wird ein einfaches Nachtsichtgerät umgeschaltet.
- Nachtsicht reduziert die Dunkelheit und legt einen grünen Overlay über die Szene.
- Es gibt bewusst kein Batterie- oder Energiesystem im MVP.

## Platzhalter-Audio
- Es gibt einfache globale Platzhalter-Sounds für MP5SD, Beretta M9, Treffer und Alarm.
- Erfolgreiche Server-/LEDGER-Interaktionen nutzen ebenfalls einen simplen Interaktions-Sound.
- Alle Sounds sind bewusst nur temporäre Beeps/Noise-Platzhalter und später leicht ersetzbar.
- Es gibt keine Musik, kein komplexes Mixing und kein Spatial Audio im MVP.

## Aktueller Status
- Phase 0 abgeschlossen: Projektstruktur, Basisdokumentation und minimale Godot-Grunddateien angelegt.
- Phase 1 abgeschlossen: Spielerbewegung, Maus-Zielen, Kamera und Testlevel mit Kollisionen vorhanden.
- Phase 2 abgeschlossen: Waffenwechsel, Kugeln, Munition, Messerangriff und Dummy-Ziele für Kampftests vorhanden.
- Phase 3 abgeschlossen: Guards mit Health, DEAD-Zustand und einfachen Patrouillenrouten im Testlevel vorhanden.
- Phase 4 abgeschlossen: Guards können den Spieler jetzt sehen, per Line-of-Sight prüfen, verfolgen und im Nah-/Mittelbereich angreifen.
- Phase 5 abgeschlossen: Globales Alarm-System, Alarm-HUD und Verknüpfung mit Sichtkontakt sowie lauten Waffen vorhanden.
- Phase 6 abgeschlossen: Mission-Level Silent Ledger mit Serverziel, Optionalziel LEDGER-7, Exfil-Zone und Missionsstatus im HUD vorhanden.
- Phase 7 abgeschlossen: Game-Over-Anzeige, sauberer Tod und Restart per R vom Missionsstart sind vorhanden.
- Phase 8 abgeschlossen: Nacht-Overlay, Nachtsicht-Toggle per N und HUD-Anzeige für Night Vision ON/OFF sind vorhanden.
- Phase 9 abgeschlossen: AudioManager, Platzhalter-Waffensounds, Treffer-Sound, Alarm-Sound und Interaktions-Sound sind vorhanden.
