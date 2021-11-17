for $klient in doc("Clients.xml")//CLIENT,
$rent in distinct-values(doc("Rent.xml")//RENT/@CLIENT_ID)
where $klient/@ID = $rent 
return
<REZULTAT>
{$klient} 
        {
        for $r in doc("Rent.xml")//RENT
        let $a := $r/xs:integer(substring(RETURN_DATE, 4, 2)) 
        let $b := $r/xs:integer(substring(FROM_DATE, 4, 2))  
        where  exists($r/RETURN_DATE) and $r/CLIENT_ID=$rent  and (($a - $b) < 10)
        return $r
        }
</REZULTAT>
