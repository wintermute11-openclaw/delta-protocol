# Delta Protocol: Operation Silent Ledger - Design

## High Concept
Delta Protocol: Operation Silent Ledger ist ein kompaktes 2D-Top-Down-Stealth-Action-MVP in Godot 4.x. Der Spieler übernimmt einen einzelnen Delta-Operator und infiltriert nachts ein Bürogebäude der Tarnfirma KRONOS Financial Systems, um sensible Serverdaten zu kopieren, optional LEDGER-7 zu sichern und über das Dach zu exfiltrieren.

## Setting
- spätes 80er- / frühes 90er-Feeling
- nächtliche Black-Ops-Atmosphäre
- kühle Corporate-Umgebung
- militärisch-taktischer Ton statt Arcade-Inszenierung

## Operation Silent Ledger
Die komplette MVP-Erfahrung besteht aus genau einer Mission. Sie beginnt am Hintereingang, führt durch Empfang, Grossraumbüro, Sicherheitsbüro und Serverraum, zwingt zu vorsichtigem Vorgehen gegen patrouillierende Guards und endet an einer Dach-Exfil-Zone.

## Levelbereiche
- Hintereingang
- Empfang
- Grossraumbüro
- Sicherheitsbüro
- Serverraum
- Treppenhaus
- Dach-Exfil-Zone

## Player
- ein einzelner spielbarer Operator
- 2D Top-Down-Bewegung
- Maus-Zielen
- normales und langsames Schleichen
- Interaktion per E
- Nachtsicht per N
- Neustart nach Tod per R

## Waffen
- MP5SD
  - schallgedämpft
  - nutzt Munition
  - löst keinen Sound-Alarm aus
- Beretta M9
  - laut
  - nutzt Munition
  - löst Alarm aus
- Messer
  - leiser Nahkampfangriff
  - keine Munition

## Gegner-KI
Guards nutzen eine einfache State Machine:
- PATROL
- SUSPICIOUS
- CHASE
- ATTACK
- DEAD

MVP-Verhalten:
- Patrouille zwischen festen Wegpunkten
- Wechsel in SUSPICIOUS bei Verlust von Sichtkontakt oder globalem Alarmkontext
- Wechsel in CHASE bei bestätigter Entdeckung
- ATTACK im Nah- bis Mittelbereich
- DEAD bei 0 Health

Bewusst nicht im MVP:
- keine Deckungs-KI
- keine Verstärkung
- keine Teamkoordination
- keine Leichenentdeckung
- keine komplexe Navigation

## Sichtsystem
- Guards besitzen Sichtkegel
- Entdeckung erfolgt nur innerhalb von Reichweite und Blickwinkel
- Wände blockieren Line-of-Sight
- Sichtprüfung läuft über Raycast gegen die Weltkollision

## Alarm-System
Globale Zustände:
- NORMAL
- SUSPICIOUS
- ALARM

Auslöser:
- Guard sieht den Player
- Beretta M9 wird abgefeuert

Wirkung:
- HUD zeigt Alarmstatus an
- Guards dürfen globale letzte bekannte Spielerpositionen als Suchziel nutzen
- Alarm-Sound wird einmalig beim Wechsel auf ALARM abgespielt

## MissionManager
MissionManager verwaltet den Missionsfluss:
- primary_objective_complete
- optional_objective_complete
- exfil_available
- mission_complete
- current_objective_text

Zusätzlich setzt er beim Missionsstart den Alarm zurück und deaktiviert Nachtsicht defensiv.

## Objectives
Primärziel:
- KRONOS-Serverdaten kopieren

Optionalziel:
- LEDGER-7 sichern

Abschluss:
- Nach Primärziel die Dach-Exfil-Zone erreichen

## Health, Death und Restart
- Player hat 3 Health
- Guards verursachen Schaden über ihre Attack-Logik
- Guards sterben nach wenig Treffern
- Bei 0 Health wechselt der Player in einen Dead-State
- Das HUD zeigt MISSION FAILED
- R lädt die aktuelle Szene neu
- Checkpoint ist nur der Missionsstart
- keine Savegames
- keine Mid-Mission-Checkpoints

## Nachtsicht
- Grundszene startet dunkel
- ein dunkles Overlay erzeugt Nachtstimmung
- N schaltet Nachtsicht um
- Nachtsicht reduziert Dunkelheit und blendet grünes Overlay ein
- kein Batterie-System
- kein Energie-System
- leicht ersetzbar durch spätere Shader- oder Lighting-Lösungen

## Audio
- AudioManager als globales Autoload
- Platzhalter-WAVs unter assets/audio/sfx/
- Sounds für:
  - MP5SD
  - Beretta M9
  - Treffer
  - Alarm
  - Interaktion
- kein Spatial Audio
- kein komplexes Mixing
- keine Musikproduktion im MVP
- alle Sounds sind bewusst ersetzbare Platzhalter

## HUD
HUD zeigt mindestens:
- aktuelles Primärziel
- Optionalziel-Status
- Missionsstatus
- Alarmstatus
- Night Vision OFF/ON
- aktuelle Waffe
- Health
- Game Over Overlay

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
- kein Save-System

## Spätere Erweiterungen
- echte lokale Godot-Laufzeitvalidierung
- Guard-Navigation über robustere Pfadlogik
- sauberere Collision Layer und Masken
- dynamische UI- und Overlay-Skalierung
- finalere Pixel-Art
- finale Soundeffekte und Mixing
- Balancing von Sichtkegeln, Schaden und Munition
- zusätzliche Missionen erst nach Stabilisierung des ersten Einsatzes
