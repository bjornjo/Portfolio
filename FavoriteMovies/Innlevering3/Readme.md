(Prosjektet heter innlevering3 da dette egentlig er versjon 3 av innlevering 1)

Om appen testes i simulator bør software keyboard skrues på, da det er tatt utgangspunkt for det i appen når bruker skal skrive inn noe.

I denne innleveringen gjenstår det uheldigvis fortsatt noen funksjoner, og noe er ikke helt optimalt.

Jeg ser noen problemer ved bruk av checkmark i søke-viewet, der markøren blir fjernet når man blar opp og ned i tableviewet.

Jeg har ikke fått implementert koden for å telle opp favorittsjanger og vise den sjangeren som dukker opp mest i favorittfilmlisten.

Jeg har brukt en deprecated metode for å laste inn bilder, men den fungerte fint likevel, men man burde nok ha tenkt på å oppdatere denne metoden med en completionhandler i stedet.

Man kan slette filmen ved å søke opp filmen på nytt. Problemet som oppstår her er at checkmarkøren ikke blir permantent lagret, så man må i så fall markere den for så å fjerne markøren igjen. Da har den forsåvidt lagt til filmen to ganger, men i det man fjerner markøren slettes alle filmene med den id'en.

Jeg har heller ikke fått til å lagre stjernevurderingen i coredata eller permanent. Jeg nedprioriterte dette da jeg tenkte det ville være samme fremgangsmåte som det ville vært når man lagrer brukers annmeldelse av filmen.

Skulle også gjerne hatt en tekst med hvordan appen fungerer om det er første gang appen åpnes eller når ingen filmer er lagt til.


KILDER:

Forelesningsslides av Håkon
The Swift Programming language (Swift 2 prerelease)
Udemy
StackOverflow
Youtube
raywenderlich
