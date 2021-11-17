<SYSTEM>
{
for $artist in doc("Artists.xml")//ARTIST
return 
<ARTIST ID="{ $artist/@ID }">
{$artist/NAME}
{$artist/COUNTRY}
{$artist/GENRE}
        
        {
        let $dj := doc("DJ.xml")//DJ[$artist/@ID = @ID]
        let $group := doc("Groups.xml")//GROUP[$artist/@ID = @ID]
        let $singer := doc("Singers.xml")//SINGER[$artist/@ID = @ID]
        
        return if ($dj)
        then <DJ ID="{ $dj/@ID }">
        {$dj/YEAR_STARTED_PERFORMING}
        {$dj/NET_WORTH}
        {$dj/YEAR_OF_BIRTH}
        
        </DJ>
        else if($group)
        then
        <GROUP ID="{$group/@ID}">
        {$group/YEAR_FORMED}
        {$group/NUMBER_OF_MEMBERS}
        </GROUP>
        else 
        <SINGER ID="{$singer/@ID}">
        {$singer/YEAR_STARTED_PERFORMING}
        {$singer/YEAR_OF_BIRTH}
        {$singer/AGE}
        </SINGER>
        } 
            <ALBUMS>
            {
            for $album in doc("Albums.xml")//ALBUM
            where $album/@ARTIST_ID = $artist/@ID 
            return
            <ALBUM ID="{$album/@ID}" ARTIST_ID="{$artist/@ID}">
            {$album/NAME}
            {$album/RELEASE_YEAR}
            {$album/PRICE}
            <CDS>
            {
            for $cd in doc("CatalogCD.xml")//CD
            where $album/@ID = $cd/@ALBUM_ID
            return 
            <CD ID="{$cd/@ID}"  ALBUM_ID="{$album/@ID }">
            {$cd/STATE}
            {$cd/OCCUPIED}
                    <RENTS>
                    {
                    for $rent in doc("Rent.xml")//RENT,
                    $klient in doc("Clients.xml")//CLIENT
                    where $rent/@CLIENT_ID = $klient/@ID and $rent/@CD_ID = $cd/@ID
                    return 
                    <RENT ID="{$rent/@ID}" CLIENT_ID="{$klient/@ID}" CD_ID="{$cd/@ID}">
                    {$rent/FROM_DATE}
                    {$rent/RETURN_STATE}
                    {$rent/RETURN_DATE}
                    
                    
                    </RENT>
                    }
                    </RENTS>

            </CD>
        }
    </CDS>
    </ALBUM>
    }
    </ALBUMS>
    </ARTIST>
}       
 
 <CLIENTS>
{
for $client in doc("Clients.xml")//CLIENT
return 
<CLIENT ID = "{$client/@ID}" >
{$client/NAME}
{$client/MIDDLE_NAME}
{$client/SURNAME}
{$client/ADDRESS}
{$client/EMAIL}
{$client/PHONE_NUMBER}
            <RENTS>
            {
            for $rent in doc("Rent.xml")//RENT,
            $cd in doc("CatalogCD.xml")//CD
            where $rent/@CD_ID = $cd/@ID  and $rent/@CLIENT_ID = $client/@ID
            return
            <RENT ID="{$rent/@ID }" CLIENT_ID="{$client/@ID}" CD_ID = "{$cd/@ID}">
            {$rent/FROM_DATE}
            {$rent/RETURN_STATE}
            {$rent/RETURN_DATE}
            </RENT>
            }   
            </RENTS>
</CLIENT> 

}
</CLIENTS>
                      
</SYSTEM>
