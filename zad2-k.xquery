declare function local:izveshtaj($mesec as xs:integer,$godina as xs:integer) as element()*
{
<Izveshtaj godina='{$godina}' mesec='{$mesec}'>
{
let $sumaOdSiteAlb := sum (
for $album in doc("Albums.xml")//ALBUM,
$catalogCD in distinct-values(doc("CatalogCD.xml")//CD/@ALBUM_ID)
where $album/@ID = $catalogCD
return
    <PROFIT>
    {       
    
    let $vkupnoIznajmuvanja := sum(
    for $cd in doc("CatalogCD.xml")//CD,
    $rent in distinct-values(doc("Rent.xml")//RENT/@CD_ID)
    where $cd/@ALBUM_ID= $catalogCD and $cd/@ID = $rent
    return 
    
    let $brojac2 := count(
    for $r in doc("Rent.xml")//RENT
    where $r/@CD_ID = $rent 
    and 
    $r/xs:integer(substring(FROM_DATE, 1, 2)) = $mesec
    and $r/xs:integer(substring(FROM_DATE, 7, 4)) = $godina
    return $r)
    return $brojac2
    
    )
    
    return  $vkupnoIznajmuvanja  * xs:double(substring($album/PRICE, 2, 5))
    }
    </PROFIT>
    )
    return
    <REZ>
    {$sumaOdSiteAlb}
    </REZ>
    }

</Izveshtaj >
};
