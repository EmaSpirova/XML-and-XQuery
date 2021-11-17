let $rez :=
                for $album in doc("Albums.xml")//ALBUM,
                $catalogCD in distinct-values(doc("CatalogCD.xml")//CD/@ALBUM_ID)
                where $album/@ID = $catalogCD
                return
                <ALBUM_CD>
                {$album}
                <PROSECHEN_BROJ_IZNAJMUVANJA>
                {       
                
                let $vkupnoIznajmuvanja := sum(
                for $cd in doc("CatalogCD.xml")//CD,
                $rent in distinct-values(doc("Rent.xml")//RENT/@CD_ID)
                where $cd/@ALBUM_ID= $catalogCD and $cd/@ID = $rent
                return 
                <BROJ_CDs_ZA_ALBUM>
                {
                let $brojac2 := count(
                for $r in doc("Rent.xml")//RENT
                where $r/@CD_ID = $rent 
                return $r)
                return $brojac2
                }
                </BROJ_CDs_ZA_ALBUM> )
                
                let $brojCDs := count(
                for $cd in doc("CatalogCD.xml")//CD,
                $rent in distinct-values(doc("Rent.xml")//RENT/@CD_ID)
                where $cd/@ALBUM_ID= $catalogCD and $cd/@ID = $rent
                return 
                <BROJ_CDs_ZA_ALBUM>
                {
                let $brojac2 := count(
                for $r in doc("Rent.xml")//RENT
                where $r/@CD_ID = $rent 
                return $r)
                return $brojac2
                }
                </BROJ_CDs_ZA_ALBUM> )
               return  $vkupnoIznajmuvanja  div $brojCDs}
                </PROSECHEN_BROJ_IZNAJMUVANJA>
                </ALBUM_CD>

for $rezultat in $rez
return $rezultat

