let $rez :=
            for $album in doc("Albums.xml")//ALBUM,
            $catalogCD in distinct-values(doc("CatalogCD.xml")//CD/@ALBUM_ID)
            where $album/@ID = $catalogCD
            return
            <ALBUM_CD>
            {$album}
            <VKUPNO_IZNAJMUVANJA_ZA_SITE_CD>
            { let $brojac := sum(
            
            for $cd in doc("CatalogCD.xml")//CD,
            $rent in distinct-values(doc("Rent.xml")//RENT/@CD_ID)
            where $cd/@ALBUM_ID= $catalogCD and $cd/@ID = $rent
            return 
            <SEKOE_CD_KOLKU_E_IZNAJMENO>
            {
            let $brojac2 := count(
            for $r in doc("Rent.xml")//RENT
            where $r/@CD_ID = $rent and
            ($r/substring(FROM_DATE, 1, 2) = "01" or $r/substring(FROM_DATE, 1, 2) = "02"
            or $r/substring(FROM_DATE, 1, 2) = "03") 
            and $r/substring(FROM_DATE, 7, 4) = "2020"
            return $r)
            return $brojac2
            }
            </SEKOE_CD_KOLKU_E_IZNAJMENO> 
            )
            return $brojac
            }
            </VKUPNO_IZNAJMUVANJA_ZA_SITE_CD>
            </ALBUM_CD>
 
 for $rezul in $rez
 where $rezul/VKUPNO_IZNAJMUVANJA_ZA_SITE_CD >= 3
 return $rezul
