let $klientiSoNajiznajmuvanAlbum :=
for $client in doc("Clients.xml")//CLIENT,
$rent in distinct-values(doc("Rent.xml")//RENT/@CLIENT_ID)
where $client/@ID = $rent

        let $sporediSoOvojAlbum :=
        let $najiznajmuvanAlbum :=
        for $album in doc("Albums.xml")//ALBUM,
        $catalogCD in distinct-values(doc("CatalogCD.xml")//CD/@ALBUM_ID)
        let $brojac := sum(           
        for $cd in doc("CatalogCD.xml")//CD,
        $rent in distinct-values(doc("Rent.xml")//RENT/@CD_ID)
        where $cd/@ALBUM_ID= $catalogCD and $cd/@ID = $rent
        return 
        <SEKOE_CD_KOLKU_E_IZNAJMENO>
        {
        let $brojac2 := count(
        for $r in doc("Rent.xml")//RENT
        where $r/@CD_ID = $rent 
        return $r)
        return $brojac2
        }
        </SEKOE_CD_KOLKU_E_IZNAJMENO> 
        )
        order by $brojac descending
        where $album/@ID = $catalogCD
        return $album
        for $rezul in  $najiznajmuvanAlbum[1]
        return $rezul

return 
<CLIENT_RENTS>
{$client}

<BROJ_NA_IZNAJMUVANJA_ZA_NAJIZNAJMUVANIOT_ALBUM>
{
let $brojac := count(
 let $iznajmuvanja := for $r in doc("Rent.xml")//RENT,
                            $catalogCD in distinct-values(doc("CatalogCD.xml")//CD/@ID)
                            where $r/@CLIENT_ID = $rent and $r/@CD_ID = $catalogCD
                            return $r
for $catCD in doc("CatalogCD.xml")//CD,
$izn in $iznajmuvanja/@CD_ID
where $catCD/@ID = $izn and $catCD/@ALBUM_ID = $sporediSoOvojAlbum/@ID
return $catCD)
return $brojac
}
</BROJ_NA_IZNAJMUVANJA_ZA_NAJIZNAJMUVANIOT_ALBUM>


<CD_ALBUM>
{

let $iznajmuvanja := for $r in doc("Rent.xml")//RENT,
$catalogCD in distinct-values(doc("CatalogCD.xml")//CD/@ID)
where $r/@CLIENT_ID = $rent and $r/@CD_ID = $catalogCD
return $r

let $zemiAlbum := for $catCD in doc("CatalogCD.xml")//CD,
$izn in $iznajmuvanja/@CD_ID
where $catCD/@ID = $izn and $catCD/@ALBUM_ID = $sporediSoOvojAlbum/@ID
return $catCD
    
    for $zemiAlb in doc("Albums.xml")//ALBUM,
    $zemiAlbum in distinct-values($zemiAlbum/@ALBUM_ID)
    where $zemiAlb/@ID = $zemiAlbum
    return $zemiAlb
}
</CD_ALBUM>

</CLIENT_RENTS>

let $zemiPrv :=
for $rezultat in $klientiSoNajiznajmuvanAlbum
where $rezultat/BROJ_NA_IZNAJMUVANJA_ZA_NAJIZNAJMUVANIOT_ALBUM > 0
order by $rezultat/BROJ_NA_IZNAJMUVANJA_ZA_NAJIZNAJMUVANIOT_ALBUM descending
return $rezultat

for $zp in $zemiPrv[1]
return $zp
