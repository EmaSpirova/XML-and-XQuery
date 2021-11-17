let $zaSekojKlientOmilenArtist :=
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
for $artist in doc("Artists.xml")//ARTIST,
$omilenArtist in distinct-values($k/ALBUM[1]/@ARTIST_ID)
where $artist/@ID = $omilenArtist
return $artist


let $sortirajPoOmileni :=
 for $artist in doc("Artists.xml")//ARTIST,
 $odSekojKlient in $zaSekojKlientOmilenArtist/@ID
 where $artist/@ID = $odSekojKlient
 return
 <ARTIST_VKUPNO_IZNAJMUVANJA>
 {$artist}
 <BROJ_FAVOURITES_KAJ_KLIENTI>{
 let $brojac := count( 
 for $klientArtist in $zaSekojKlientOmilenArtist
 where $klientArtist/@ID = $odSekojKlient
 return $klientArtist)
 return $brojac
 }
 </BROJ_FAVOURITES_KAJ_KLIENTI>
 </ARTIST_VKUPNO_IZNAJMUVANJA>
 
 let $zemiPrv :=
 for $sort in $sortirajPoOmileni
 order by $sort/BROJ_FAVOURITES_KAJ_KLIENTI descending
 return $sort
 
        for $prv in $zemiPrv[1]/ARTIST
        return
        <OMILEN_ARTIST>
        {$prv}
        </OMILEN_ARTIST>
