Fertigung und Produktion
=======================

Dieser Abschnitt beschreibt den Fertigungsprozess und die Produktionsdateien für das 4CH-Opto-ISO Board.

Automatisierte Produktion mit KiCad-CLI
---------------------------------------

Das Projekt nutzt die KiCad-CLI Docker-Umgebung für eine vollautomatisierte Generierung aller Produktionsdateien:

.. code-block:: bash

   # Vollständiger Export aller Produktionsdateien
   docker run --rm -v $(pwd):/workspace kicaddev-cli kicad_export 4CH-Opto-ISO.kicad_pro

Generierte Dateien
-----------------

Gerber-Dateien
~~~~~~~~~~~~~

Die Gerber-Dateien befinden sich im Verzeichnis ``production/gerbers/`` und umfassen:

* **Kupferlagen:**
  
  * ``4CH-Opto-ISO-F_Cu.gtl`` - Oberseite (Top Layer)
  * ``4CH-Opto-ISO-B_Cu.gbl`` - Unterseite (Bottom Layer)

* **Lötmasken:**
  
  * ``4CH-Opto-ISO-F_Mask.gts`` - Lötmaske Oberseite
  * ``4CH-Opto-ISO-B_Mask.gbs`` - Lötmaske Unterseite

* **Siebdruck:**
  
  * ``4CH-Opto-ISO-F_Silkscreen.gto`` - Siebdruck Oberseite
  * ``4CH-Opto-ISO-B_Silkscreen.gbo`` - Siebdruck Unterseite

* **Weitere Lagen:**
  
  * ``4CH-Opto-ISO-Edge_Cuts.gm1`` - Platinenkonturen
  * ``4CH-Opto-ISO.drl`` - Bohrdatei

Dokumentation
~~~~~~~~~~~~

* **Schaltplan PDF:** ``pdf/4CH-Opto-ISO_schematic.pdf``
* **Layout PDF:** ``pdf/4CH-Opto-ISO_pcb.pdf``
* **3D-Modell:** ``3d/4CH-Opto-ISO.step``

Bill of Materials (BOM)
~~~~~~~~~~~~~~~~~~~~~~

* **Interaktive HTML-BOM:** ``bom/4CH-Opto-ISO_ibom.html``
* **CSV-BOM:** [wird bei Bedarf generiert]

Fertigungsparameter
------------------

PCB-Spezifikationen
~~~~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Parameter
     - Wert
   * - Lagenanzahl
     - 2
   * - PCB-Dicke
     - 1.6 mm
   * - Kupferdicke
     - 35 μm (1 oz)
   * - Minimale Leiterbahnbreite
     - 0.2 mm
   * - Minimaler Via-Durchmesser
     - 0.3 mm
   * - Oberflächenbehandlung
     - HASL oder ENIG

Lötparameter
~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Parameter
     - Wert
   * - Löttemperatur
     - 240-260°C
   * - Vorheiztemperatur
     - 150-180°C
   * - Lötzeit
     - 3-5 Sekunden
   * - Lottyp
     - SAC305 (bleifreies Lot)

Qualitätskontrolle
-----------------

Automatisierte Prüfungen
~~~~~~~~~~~~~~~~~~~~~~~

* **DRC (Design Rule Check)** - Integriert in KiCad-CLI
* **ERC (Electrical Rules Check)** - Automatische Schaltplanprüfung
* **Gerber-Verifikation** - Visuelle Kontrolle der generierten Dateien

Funktionstests
~~~~~~~~~~~~~

* **Isolationsprüfung** - 5000V Isolationstest
* **Kontinuitätsprüfung** - Leiterbahnkontinuität
* **Funktionstest** - End-to-End Signalübertragung

Fertigungspartner
----------------

Das Design ist kompatibel mit gängigen PCB-Herstellern:

* **JLCPCB** - Kostengünstige Prototypen
* **PCBWay** - Professionelle Fertigung
* **OSH Park** - Community-orientierte Fertigung
* **Lokale Hersteller** - Je nach Region

.. note::
   Laden Sie das komplette Fertigungspaket ``4CH-Opto-ISO_manufacturing.zip`` 
   herunter und senden Sie es direkt an Ihren bevorzugten PCB-Hersteller.

Kostenschätzung
--------------

Typische Kosten für Prototyping (Stand 2025):

.. list-table::
   :header-rows: 1
   :widths: 20 30 25 25

   * - Stückzahl
     - PCB-Kosten
     - Bauteile
     - Gesamt
   * - 5 Stück
     - $15-25
     - $10-15
     - $25-40
   * - 10 Stück
     - $20-30
     - $20-30
     - $40-60
   * - 100 Stück
     - $50-80
     - $150-200
     - $200-280

.. warning::
   Preise können je nach Hersteller, Spezifikationen und aktueller Marktlage variieren.
