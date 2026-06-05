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

Geplante spätere Steuerungserweiterungen:
- N: Nachtsichtgerät umschalten
- R: Mission nach Tod neu starten

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

## Aktueller Status
- Phase 0 abgeschlossen: Projektstruktur, Basisdokumentation und minimale Godot-Grunddateien angelegt.
- Phase 1 abgeschlossen: Spielerbewegung, Maus-Zielen, Kamera und Testlevel mit Kollisionen vorhanden.
- Phase 2 abgeschlossen: Waffenwechsel, Kugeln, Munition, Messerangriff und Dummy-Ziele für Kampftests vorhanden.
- Phase 3 abgeschlossen: Guards mit Health, DEAD-Zustand und einfachen Patrouillenrouten im Testlevel vorhanden.
- Phase 4 abgeschlossen: Guards können den Spieler jetzt sehen, per Line-of-Sight prüfen, verfolgen und im Nah-/Mittelbereich angreifen.
- Phase 5 abgeschlossen: Globales Alarm-System, Alarm-HUD und Verknüpfung mit Sichtkontakt sowie lauten Waffen vorhanden.
- Phase 6 abgeschlossen: Mission-Level Silent Ledger mit Serverziel, Optionalziel LEDGER-7, Exfil-Zone und Missionsstatus im HUD vorhanden.
