Om appen

Dette er et prosjekt jeg har utviklet i sammenheng med faget iOS-programmering på Westerdals Oslo ACT.
Hensikten med appen er at man skal kunne søke etter filmer fra et API (OMDB), 
og legge til filmene i en favorittliste der man kan gi sin egen tilbakemelding om filmen.

Retningslinjer for test av appen:
- Om appen testes i simulator bør software keyboard skrues på (CMD + K), 
da det er tatt utgangspunkt for det i appen når bruker skal skrive inn noe.
- Det ligger ingen filmer per default i listen i startskjermen. 
- Legg til en film ved å klikke "Finn filmer"
- Søk etter f.eks. "Harry", og en liste over filmer som inneholder denne stringen vil vises.
- Marker en film for å legge den til i favorittlista, avmarker for å fjerne
- De som er lagt til legges i "Mine Filmer", og er lagret i minnet.
- Klikk på en film i favorittlista - Her kan man skrive i tekstfeltet og se mer informasjon om filmen (Hentet fra API'et)
- Skriver man i tekstfeltet og klikker utenfor tekstboksen, blir teksten lagret til filmen, 
så om man går ut av appen og inn på filmen igjen vil teksten fortsatt være der

Prosjektet er desverre ufullstendig, og har visse mangler:
- Jeg ser noen problemer ved bruk av checkmark i søke-viewet, der markøren blir fjernet når man blar opp og ned i tableviewet. 
(Mistenker bugs ved bruk av reusable cells)
- Man kan slette filmen ved å søke opp filmen på nytt. 
Problemet som oppstår her er at checkmarkøren ikke blir permantent lagret, så man må i så fall markere den for så å fjerne markøren igjen. 
Da har den forsåvidt lagt til filmen to ganger, men i det man fjerner markøren slettes alle filmene med den id'en.
