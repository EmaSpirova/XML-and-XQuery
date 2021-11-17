for $artist in doc("Artists.xml")//ARTIST,
$album in distinct-values(doc("Albums.xml")//ALBUM/@ARTIST_ID)
where $artist/@ID = $album
return 
<ARTISTRESULT>
{$artist}
        {
        for $al in doc("Albums.xml")//ALBUM
        where $al/@ARTIST_ID=$album
        return 
        <TitleDate>
        {$al/NAME}
        {$al/RELEASE_YEAR}
        </TitleDate>
        }
</ARTISTRESULT>