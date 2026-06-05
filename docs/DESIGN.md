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

Geplante Levelbereiche:
- Hintereingang
- Empfang
- Grossraumbüro
- Sicherheitsbüro
- Serverraum
- Treppenhaus
- Dach-Exfil-Zone

## Kernmechaniken
- 2D Top-Down-Bewegung
- Maus-Zielen
- Schleichen mit reduzierter Geschwindigkeit
- Waffenwechsel zwischen MP5SD, Beretta M9 und Messer
- Einfaches Stealth-System mit Sichtkegeln
- Interaktion mit Missionsobjekten
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

Verhaltensrahmen:
- Patrouille zwischen festen Wegpunkten
- Sichtprüfung über Reichweite, Blickwinkel und freie Sichtlinie ohne Wandblocker
- Untersuchung letzter bekannter Spielerposition bei Verdacht
- Verfolgung und Angriff nach bestätigter Entdeckung
- Keine komplexe Deckungs- oder Team-KI im MVP

## Alarm-System
Globale Zustände:
- Normal
- Verdacht
- Alarm

Auslöser:
- Sichtkontakt im Sichtkegel
- laute Schüsse der Beretta M9

Wirkung:
- Gegner wechseln in Such-, Verfolgungs- oder Angriffsverhalten
- HUD zeigt den aktuellen Alarmstatus an

Hinweis:
- Ein einzelner Guard darf in Phase 4 bereits lokal entdecken, verfolgen und angreifen.
- Ein globaler Alarmstatus für mehrere Gegner kommt erst in Phase 5.

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
