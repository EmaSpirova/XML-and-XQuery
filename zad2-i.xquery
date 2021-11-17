let $sortiraniRezultatiZaArtisti :=
for $client in doc("Clients.xml")//CLIENT,
$rent in distinct-values(doc("Rent.xml")//RENT/@CLIENT_ID)
where $client/@ID = $rent
return 
<KLIENT>
{$client/@ID}

                { let $proba :=      let $iznajmeniCDS := 
                for $r in doc("Rent.xml")//RENT[@CLIENT_ID= $rent]
                return 
                for $catalogCD in doc("CatalogCD.xml")//CD,
                $cd in $r
                where $catalogCD/@ID = $cd/@CD_ID
                return $catalogCD
                
                for $album in doc("Albums.xml")//ALBUM, 
                $izncd in $iznajmeniCDS
                where $album/@ID = $izncd/@ALBUM_ID 
                return $album
                
                for $artist in doc("Artists.xml")//ARTIST,
                $a in distinct-values($proba/@ARTIST_ID)
                where $artist/@ID = $a
                
                order by count(for $art in $proba
                where $art/@ARTIST_ID = $a 
                return $art) descending
                return 
                
                                 
                for $art in $proba
                where $art/@ARTIST_ID = $a 
                return $art
                
                
                
                }

</KLIENT>

for $klient in $sortiraniRezultatiZaArtisti,
$k in $klient
return 
    <KLIENT>
    {$klient/@ID}
       <OMILEN_ARTIST>
        {
               for $artist in doc("Artists.xml")//ARTIST,
               $omilenArtist in distinct-values($k/ALBUM[1]/@ARTIST_ID)
               where $artist/@ID = $omilenArtist
               return $artist
        }
        </OMILEN_ARTIST>
    </KLIENT>

