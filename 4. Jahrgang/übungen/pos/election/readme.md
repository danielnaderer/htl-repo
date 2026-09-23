## Election

Gegeben ist eine legacy CLI-Applikation `Wahl.java`. Der Kunde wünscht eine **Erweiterung** der Applikation um zusätzliche Features.
Die ursprünglichen Entwickler sind nicht auffindbar, die Dokumentation nicht vorhanden, Tests waren nie budgetiert, etc.

* Studiere `Wahl.java` beziehungsweise starte die Applikation und experimentiere, um das Verhalten herauszufinden.
* Die Applikation wird zum Abwickeln von Abteilungssprecherwahlen verwendet.
* Die gesamte bekannte Dokumentation des Ablaufs ist der Code.
* Refactoring

  * Installiere das Plugin *Code Metrics* und setze `Show metrics above complexity` auf < 10.
    * Akzeptable [Komplexität](https://en.wikipedia.org/wiki/Cyclomatic_complexity) < 10 (Ausgenommen `equals`).
    * Refaktoriere die gesamte vorhandene Codebase hinsichtlich SOLID & Clean Code.
* Optional auch kompletter rewrite mit beliebigen Technologien.
* 80% Test Coverage.

* Zusätzliche Features:
  * Korrektur einer getätigten Eingabe.
  * Löschen einer getätigten Eingabe.
  * Support für Namensgleichheit bei < 10 Kandidaten.
  * Optional GUI.

#### Rechtliche Grundlagen
[Schulunterrichtsgesetz](https://www.ris.bka.gv.at/GeltendeFassung.wxe?Abfrage=Bundesnormen&Gesetzesnummer=10009600)
* §59 (3)
* §59a