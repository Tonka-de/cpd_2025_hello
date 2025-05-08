# Flutter Aufgaben

Link zu [Aufgabe 4](https://github.com/Tonka-de/cpd_2025_hello/tree/aufgabe4)

## Aufgabe war:

Erstellt eine JSON-Datei für die Todos mit folgenden Informationen:

- Todo-Name
- Todo-Nummer
- Todo-Status
- Todo-Deadline

Ladet diese JSON-Datei in eure App.

## Info

Der Login wurde temporär deaktiviert. Es ist nicht ziel der Aufgabe, sollte daher nicht das Aufgabenrelevante verhindern.

## Credentials

Username: admin
Password: password123

## Getestet:

Auf Arch-Linux nativ. Dafür wird ein fix wegen dem _Flutter-Secure-Storage_ benötigt. Der Fix ist [hier](https://github.com/juliansteenbakker/flutter_secure_storage/issues/829#issuecomment-2824565287) zu finden. Der Fix ist ist nicht schön und eher temporär, aber etwas besseres gibt es derzeit wohl nicht.

Es wurde bewusst **nicht** im Browser getestet, einfach aus dem Grund, dass der Browser es einer Webseite verbietet auf das File-System zuzugreifen. Da Flutter im Web auch nur eine Webseite ist, kann es daher nicht im Browser funktionieren.
