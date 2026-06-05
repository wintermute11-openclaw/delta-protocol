# Manual Testing Checklist

Diese Liste ist fuer den ersten lokalen Godot-Test gedacht.

## Projektstart
1. Godot 4.x starten.
2. /home/claw/delta_protocol/project.godot importieren.
3. Main-Szene oder Projekt-Play starten.
4. Pruefen, ob die Mission Silent Ledger ohne sofortige Fehler laedt.

## Bewegung und Kamera
5. WASD und Pfeiltasten testen.
6. Shift und Ctrl fuer langsames Bewegen testen.
7. Maus-Zielen und Kamera-Folgen pruefen.
8. Kollision mit Waenden pruefen.

## Waffen und Kampf
9. Mit 1 auf MP5SD wechseln.
10. Mit 2 auf Beretta M9 wechseln.
11. Mit 3 auf Messer wechseln.
12. Schiessen und Nahkampfangriff pruefen.
13. Munition und Weapon-Anzeige im HUD beobachten.

## Alarm und Stealth
14. MP5SD abfeuern und pruefen, dass kein Sound-Alarm ausgeloest wird.
15. Beretta abfeuern und pruefen, dass ALARM gesetzt wird.
16. Guard-Sichtkegel testen.
17. Guards hinter Waenden beobachten und pruefen, dass Waende die Sicht blockieren.
18. Chase- und Attack-Verhalten nach Entdeckung pruefen.

## Missionsziele
19. ServerTerminal erreichen und mit E interagieren.
20. Pruefen, dass das Primärziel abgeschlossen wird.
21. LedgerFile erreichen und mit E interagieren.
22. Pruefen, dass das Optionalziel abgeschlossen wird.
23. ExfilZone vor Abschluss des Primärziels betreten und Verhalten beobachten.
24. ExfilZone nach Abschluss des Primärziels betreten und Missionsabschluss pruefen.

## Health, Death und Restart
25. Sich von Guards treffen lassen.
26. Health-Anzeige im HUD beobachten.
27. Player-Tod und MISSION FAILED pruefen.
28. Mit R den Neustart vom Missionsstart pruefen.
29. Nach dem Neustart pruefen, dass Alarm und Missionsstatus zurueckgesetzt sind.

## Nachtsicht und Audio
30. N druecken und Night Vision OFF/ON pruefen.
31. Lesbarkeit von Szene und HUD mit Nachtsicht pruefen.
32. Platzhalter-Sounds fuer MP5SD, Beretta, Treffer, Alarm und Interaktion pruefen.

## Erwartete MVP-Einschraenkungen
- Grafik ist Platzhalter und nicht final.
- Sounds sind Platzhalter und nicht final gemischt.
- HUD ist funktional, aber optisch noch simpel.
- Guard-Navigation ist bewusst einfach.
- Checkpoint ist nur der Missionsstart.
- Nachtsicht nutzt ein simples Overlay statt finalem Lighting.
