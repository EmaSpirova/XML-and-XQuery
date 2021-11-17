let $sortedClients :=
            for $client in doc("Clients.xml")//CLIENT,
            $rent in distinct-values(doc("Rent.xml")//RENT/@CLIENT_ID)
            order by count(doc("Rent.xml")//RENT[@CLIENT_ID= $rent]) descending
            where $client/@ID = $rent 
            return $client

for $c in $sortedClients[position() >= 1 and position() <= 3]
return $c
