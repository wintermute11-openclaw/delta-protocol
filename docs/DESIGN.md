# Delta Protocol: Operation Silent Ledger — Design

## Spielkonzept
Delta Protocol ist ein 2D-Top-Down-Stealth-Action-Spiel mit kompaktem MVP-Fokus. Der Spieler übernimmt einen einzelnen Delta-Operator und absolviert genau eine nächtliche Black-Ops-Mission in einem Bürogebäude.

## Setting
- Zeitraum und Ton: spätes 80er- / frühes 90er-Feeling
- Ort: Tarnfirma KRONOS Financial Systems
- Atmosphäre: Nacht, geringe Sicht, kühle Corporate-Umgebung, taktische Infiltration

## Mission: Operation Silent Ledger
Ziel der Mission ist der verdeckte Einstieg über den Hintereingang, das Erreichen des Serverraums, das Kopieren sensibler Daten und die anschliessende Exfiltration über das Dach.

Missionsziele:
1. Primärziel: Daten vom KRONOS-Server kopieren
2. Optionalziel: Akte LEDGER-7 im Sicherheitsbüro sichern
3. Exfiltration: Dach-Exfil-Zone erreichen

Räume / Bereiche im MVP-Level:
- Hintereingang als Startpunkt
- Empfang
- Grossraumbüro
- Sicherheitsbüro
- Serverraum
- Treppenhaus
- Dach-Exfil-Zone

Missionsabschluss:
- Das Primärziel schaltet Exfil frei.
- Das Optionalziel ist separat und nicht zwingend für den Erfolg.
- Die Mission gilt als abgeschlossen, wenn der Player nach dem Primärziel die Exfil-Zone erreicht.

## Kernmechaniken
- 2D Top-Down-Bewegung
- Maus-Zielen
- Schleichen mit reduzierter Geschwindigkeit
- Waffenwechsel zwischen MP5SD, Beretta M9 und Messer
- Einfaches Stealth-System mit Sichtkegeln
- Interaktion mit Missionsobjekten per E
- Einfache Treffer- und Gesundheitslogik
- Ein Missionsstart-Checkpoint

## Ausrüstung
- MP5SD: schallgedämpft, leise, kein Sound-Alarm durch Schuss
- Beretta M9: laut, Schüsse lösen Alarm aus
- Messer: leise Nahkampfwaffe
- Datenkopiergerät: Interaktion für das Primärziel
- Nachtsichtgerät: einfacher grüner Overlay- oder Helligkeitsmodus

## Gegner-KI
Geplante einfache State Machine:
- PATROL
- SUSPICIOUS
- CHASE
- ATTACK
- DEAD

Phasenstand:
- Phase 3: Guards nutzen PATROL und DEAD.
- Phase 4: Guards nutzen Sichtkegel, Raycast-Line-of-Sight sowie SUSPICIOUS, CHASE und ATTACK.
- Phase 5: Globales Alarm-System verknüpft mehrere Guards und laute Ereignisse.
- Phase 6: Missionsebene und Missionsziele laufen parallel zur bestehenden Guard-KI, ohne neue komplexe Teamlogik.

Verhaltensrahmen:
- Patrouille zwischen festen Wegpunkten
- Sichtprüfung über Reichweite, Blickwinkel und freie Sichtlinie ohne Wandblocker
- Untersuchung letzter bekannter Spielerposition bei Verdacht
- Verfolgung und Angriff nach bestätigter Entdeckung
- Guards dürfen bei globalem Alarm die globale letzte bekannte Spielerposition als Suchziel nutzen
- Keine Verstärkung, keine Deckungs-KI und keine komplexe Teamtaktik im MVP

## Alarm-System
Globale Zustände:
- NORMAL
- SUSPICIOUS
- ALARM

Auslöser:
- Sichtkontakt eines Guards mit dem Player
- laute Schüsse der Beretta M9
- Verlust von Sichtkontakt kann Verdacht aufrechterhalten, solange noch kein globaler Alarm aktiv ist

Wirkung:
- HUD zeigt den aktuellen Alarmstatus an
- Guards dürfen bei globalem Alarm ihre Suche auf die globale letzte bekannte Spielerposition ausrichten
- Guards behalten trotzdem einfache lokale CHASE/ATTACK-Logik pro Instanz

Hinweis:
- MP5SD bleibt akustisch leise und löst keinen Alarm durch Sound aus.
- Phase 5 enthält bewusst keine Verstärkung, Funklogik, Deckung oder Leichenentdeckung.

## Missionssystem
MissionManager verwaltet:
- primary_objective_complete
- optional_objective_complete
- exfil_available
- mission_complete
- current_objective_text

Interaktionsobjekte:
- ServerTerminal: erfüllt das Primärziel
- LedgerFile: erfüllt das Optionalziel
- ExfilZone: beendet die Mission nur bei abgeschlossenem Primärziel

HUD-Status im MVP:
- aktuelles Primärziel
- Optionalziel [OPEN/DONE]
- Mission ACTIVE/COMPLETE
- Alarmstatus

## Nicht-MVP-Scope
- keine Teamsteuerung
- keine mehreren Missionen
- keine Fahrzeuge
- kein komplexes Inventar
- keine Deckungs-KI
- keine Leichen-entdecken-Mechanik
- kein Level-Editor
- kein komplexes Ballistiksystem
- kein Dialogsystem
