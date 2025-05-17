# Flutter Aufgaben

Link zu [Aufgabe 4](https://github.com/Tonka-de/cpd_2025_hello/tree/aufgabe4)

## Aufgabe war:

Eine Datenbank an die App anzubinden. Bevorzugt eine GraphQL Datenbank, wobei nach nachfrage auch PostgreSQL in Ordnung wäre.

## Info

Der Login wurde temporär deaktiviert. Es ist nicht ziel der Aufgabe, sollte daher nicht das Aufgabenrelevante verhindern.

## Credentials

Username: admin
Password: password123

## Getestet:

Auf Arch-Linux nativ. Dafür wird ein fix wegen dem _Flutter-Secure-Storage_ benötigt. Der Fix ist [hier](https://github.com/juliansteenbakker/flutter_secure_storage/issues/829#issuecomment-2824565287) zu finden. Der Fix ist ist nicht schön und eher temporär, aber etwas besseres gibt es derzeit wohl nicht.

Getestet in: Browser, Archlinux, Windows.

## Anleitung:

Um das Projekt zu starten, bitte stelle sicher, dass Docker installiert ist.

Dann befindet sich im root des Projekts eine `docker-compose.yaml`. Mit dem Terminal einfach `docker compose up -d` im root des Projekts ausführen, dann ist die Datenbank schon eingerichtet.

Danach kann ganz normal über `flutter run` das Projekt gestartet werden.
