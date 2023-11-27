---
layout: default
title: TEI
permalink: 2_dtd_tei
---

class: center, middle

# TEI-Kurs

Matthias Richter

.mail[matthias.richter@slub-dresden.de]

---

class: middle

# Fahrplan Kurs

1. XML (Extensible Markup Language), DTD (Document Type Definition)
2. DTD, Oxygen, TEI (Text Encoding Initiative)
3. Übung Transkription
4. Weiteres: Correspsearch, Oxygen-Alternativen, XSLT/HTML

---

class: middle

# Fahrplan heute

- Namenskonflikte und Namespaces
- DTD

---

layout: true

# Namenskonflikte und Namespaces

---

## Namenskonflikt

```
<document>
    <table>
        <row>
            <cell> 1 </cell>
            <cell> 2 </cell>
        </row>
        <row>
            <cell> 3 </cell>
            <cell> 4 </cell>
        </row>
    </table>

    <table>
        <material> wood </material>
        <width unit="cm"> 80 </width>
        <height unit="cm"> 60 </height>
    </table>
</document>
```

---

# Namespaces

```
<document>
    <maths:table>
        <maths:row>
            <maths:cell> 1 </maths:cell>
            <maths:cell> 2 </maths:cell>
        </maths:row>
        <maths:row>
            <maths:cell> 3 </maths:cell>
            <maths:cell> 4 </maths:cell>
        </maths:row>
    </maths:table>

    <furniture:table>
        <furniture:material> wood </furniture:material>
        <furniture:width unit="cm"> 80 </furniture:width>
        <furniture:height unit="cm"> 60 </furniture:height>
    </furniture:table>
</document>
```

Elementnamen können mit einem durch : abgetrenntem **Präfix** versehen werden.
Dieses Präfix bezeichnet den **Namespace**, also den semantischen Kontext des Elements.

---

# Gebundene Namespaces

```
<document>
    <maths:table xmlns:maths="https://slub-dresden.de/maths">
        <maths:row>
            <maths:cell> 1 </maths:cell>
            <maths:cell> 2 </maths:cell>
        </maths:row>
        <maths:row>
            <maths:cell> 3 </maths:cell>
            <maths:cell> 4 </maths:cell>
        </maths:row>
    </maths:table>

    <furniture:table xmlns:furniture="https://slub-dresden.de/furniture">
        <furniture:material> wood </furniture:material>
        <furniture:width unit="cm"> 80 </furniture:width>
        <furniture:height unit="cm"> 60 </furniture:height>
    </furniture:table>
</document>
```

Namespaces müssen durch ein xmlns-Attribut **gebunden** werden.
In diesem Attribut werden URLs hinterlegt, die die Einzigartigkeit des Namespaces sicherstellen sollen.
Sie können auf eine Information zum genutzten Namespace zeigen.

---

# Gebundene Namespaces

```
<document xmlns:maths="https://slub-dresden.de/maths" xmlns:furniture="https://slub-dresden.de/furniture">
    <maths:table>
        <maths:row>
            <maths:cell> 1 </maths:cell>
            <maths:cell> 2 </maths:cell>
        </maths:row>
        <maths:row>
            <maths:cell> 3 </maths:cell>
            <maths:cell> 4 </maths:cell>
        </maths:row>
    </maths:table>

    <furniture:table>
        <furniture:material> wood </furniture:material>
        <furniture:width unit="cm"> 80 </furniture:width>
        <furniture:height unit="cm"> 60 </furniture:height>
    </furniture:table>
</document>
```

Die xmlns-Attribute können auch in einem Elternelement definiert werden, beispielsweise im Wurzelelement.

---

# Gebundene Namespaces

```
<document 
        xmlns:maths="https://slub-dresden.de/maths"
        xmlns:furniture="https://slub-dresden.de/furniture">
    <maths:table>
        <maths:row>
            <maths:cell> 1 </maths:cell>
            <maths:cell> 2 </maths:cell>
        </maths:row>
        <maths:row>
            <maths:cell> 3 </maths:cell>
            <maths:cell> 4 </maths:cell>
        </maths:row>
    </maths:table>

    <furniture:table>
        <furniture:material> wood </furniture:material>
        <furniture:width unit="cm"> 80 </furniture:width>
        <furniture:height unit="cm"> 60 </furniture:height>
    </furniture:table>
</document>
```
---

# Default-Namespaces

```
<document>
    <table xmlns="https://slub-dresden.de/maths">
        <row>
            <cell> 1 </cell>
            <cell> 2 </cell>
        </row>
        <row>
            <cell> 3 </cell>
            <cell> 4 </cell>
        </row>
    </table>

    <table xmlns="https://slub-dresden.de/furniture">
        <material> wood </material>
        <width unit="cm"> 80 </width>
        <height unit="cm"> 60 </height>
    </furniture:table>
</document>
```

Namespaces können auch unbenannt bleiben.
Das xmlns-Attribut führt einen Namespace für das aktuelle Element und alle Kindelemente ein.

---

layout: true

# DTD

---

Document Type Definition

- legt genutzte Elemente fest
- definiert Kontexte für Elemente
- legt genutzte Attribute fest
- Basis für *Validität*

---

## Elementdeklarationen

Dieses Dokument:

```
<person>
    <name>
        <first_name> Alan </first_name>
        <last_name> Turing </last_name>
    </name>
    <profession>
        computer scientist
    </profession>
    <profession>
        mathematician>
    </profession>
    <profession>
        code breaker
    </profession>
</person>
```

kann mit dieser DTD beschrieben werden:

```
<!ELEMENT person (name, profession*)>
<!ELEMENT name (first_name, last_name)>
<!ELEMENT first_name (#PCDATA)>
<!ELEMENT last_name (#PCDATA)>
<!ELEMENT profession (#PCDATA)>
```

---

valide:

```
<person>
    <name>
        <first_name> Alan </first_name>
        <last_name> Turing </last_name>
    </name>
</person>
```

nicht valide:

```
<person>
    <profession>
        computer scientist
    </profession>
    <profession>
        mathematician>
    </profession>
    <profession>
        code breaker
    </profession>
</person>
```

---

valide:

```
<person>
    <profession>
        computer scientist
    </profession>
    <name>
        <first_name> Alan </first_name>
        <last_name> Turing </last_name>
    </name>
</person>
```

nicht valide:

```
<person>
    <name>
        <first_name> Alan </first_name>
        <last_name> Turing </last_name>
    </name>
    was a
    <profession>
        computer scientist
    </profession>
    ,
    <profession>
        mathematician>
    </profession>
    , and
    <profession>
        code breaker
    </profession>
</person>
```

---

## Kardinalitäten und Optionen

Kardinalitäten werden durch Suffixe ausgedrückt:

- \* 0-n
- ? 0, 1
- \+ 1-n

Optionen werden durch die Pipe | markiert:

```
<!ELEMENT responsible_person (author | editor)>
```

Leere Elemente werden mit EMPTY angezeigt

```
<img src="path_to_source"/>

<!ELEMENT img EMPTY>
```

---

Gemischte Inhalte können mithilfe von #PCDATA, der Pipe und * erlaubt werden:

```
<p>
    Dies ist ein Absatz mit <i> kursiven </i> und <b> fetten </b> Auszeichnungen.
</p>

<!ELEMENT p (#PCDATA | i | b)*>
<!ELEMENT i (#PCDATA)*>
<!ELEMENT b (#PCDATA)*>
```

---

## Attribute

Dieser Datensatz:

```
<term>
    <name lang="english"> computer </name>
    <name lang="german"> rechner </name>
</term>
```

wird durch diese DTD beschrieben:

```
<!ELEMENT term (name)*>
<!ELEMENT name (#PCDATA)>
<!ATTLIST name lang CDATA #REQUIRED>
```

---

## ATTLISTS

Jeder Eintrag einer ATTLIST besteht aus dem Attributnamen, dem Attributwertebereich und dem Attributwert.

--

## Wertebereich

normalerweise CDATA, es können aber auch Aufzählungen gegeben werden: `<!ATTLIST name lang (english|german) #REQUIRED.

--

## Wert

- \#REQUIRED: Attribut muss angegeben werden
- \#IMPLIED: Attribut ist fakultativ
- \#FIXED: Attribut hat festen Wert

```
<!ATTLIST name lang #FIXED "english">

---

layout: false
class: middle, center

# Übung DTD

---

class: center

Digital Archive of Letters in Flanders

vnsbrieven.org/vns/browse.xq

Thomas Gray Archive

thomasgray.org/texts/letters.shtml

Berliner Intellektuelle

berliner-intellektuelle.eu/genre?de

Weber-Gesamtausgabe

weber-gesamtausgabe.de (Weber &gt; Korrespondenz)

Digitale Edition der Korrespondenz August Wilhelm Schlegels

august-wilhem-schlegel.de/briefedigital
