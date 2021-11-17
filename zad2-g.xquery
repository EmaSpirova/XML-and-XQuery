let $rez :=
            for $album in doc("Albums.xml")//ALBUM,
            $catalogCD in distinct-values(doc("CatalogCD.xml")//CD/@ALBUM_ID)
            where $album/@ID = $catalogCD
            
            let $brojac := sum(           
            for $cd in doc("CatalogCD.xml")//CD,
            $rent in distinct-values(doc("Rent.xml")//RENT/@CD_ID)
            where $cd/@ALBUM_ID= $catalogCD and $cd/@ID = $rent
            and ($cd/[OCCUPIED] = "0" or $cd/[OCCUPIED] = "free") 
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
            return  $album
 
 for $group in doc("Groups.xml")//GROUP,
 $artist in distinct-values(doc("Artists.xml")//ARTIST/@ID),
 $rezul in distinct-values($rez[1]/ @ARTIST_ID) 
where $artist= $rezul and $group/@ID = $artist
return $group
