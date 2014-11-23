let $fpath := "ta_tripsterdata.xml"
return <database>
  <TRIP>{
    for $user at $index in doc($fpath) / tripster / user
    for $trip in $user/trip
    return
      <tuple>
        <TID>{data($trip/id)}</TID>
        <LOCATION>{data($trip/location/name)}</LOCATION>
        <NAME>{data($trip/name)}</NAME>
        <PRIVACY_FLAG>{data($trip/privacyFlag)}</PRIVACY_FLAG>
        <USERID>{data($index - 1)}</USERID>
      </tuple>
  }</TRIP>
    
  <USERS>{
    for $user at $index in doc($fpath) / tripster / user
    return
      <tuple>
        <USERID>{data($index)}</USERID>
        <ENCRYPTEDPASS>null</ENCRYPTEDPASS>
        <AFFILIATION>{data($user/affiliation)}</AFFILIATION>
        <NAME>{data($user/name)}</NAME>
        <EMAIL>{data($user/email)}</EMAIL>
      </tuple>
  }</USERS>
  
  <FRIEND>{
    for $user at $index1 in doc($fpath) / tripster / user
    for $person at $index2 in doc($fpath) / tripster / user 
    where $person/login = $user/friend and $index2 > $index1
    return
      <tuple>
        <FRIEND1>{data($index1)}</FRIEND1>
        <FRIEND2>{data($index2)}</FRIEND2>
      </tuple>
  }</FRIEND>

  (: WENT ON TABLE HERE:)

  <INVITE>{
    for $user at $index1 in doc($fpath) / tripster / user
    for $trip in $user/trip
    for $invite in $user/invite [status = "pending"]
    for $person at $index2 in doc($fpath) / tripster / user 
    where $person/login = $invite/friendid and $index2 > $index1
    return
      <tuple>
        <INVITER>{data($index1)}</INVITER>
        <INVITEE>{data($index2)}</INVITEE>
        <TID>{data($trip/id)}</TID>
      </tuple>
  }</INVITE>
  
  <ALBUMS>{
    for $user at $index in doc($fpath) / tripster / user
    for $trip in $user/trip
    for $album in $trip/album
    return
      <tuple>
        <TID>{data($trip/id)}</TID>
        <AID>{data($album/id)}</AID>
        <Name>{data($album/name)}</Name>
        <PRIVACY_FLAG>{data($album/privacyFlag)}</PRIVACY_FLAG>
      </tuple>
  }</ALBUMS>
  
  <CONTENT>{
    for $user at $index in doc($fpath) / tripster / user
    for $trip in $user/trip
    for $album in $trip/album
    for $content in $album / content
    return
      <tuple>
        <TID>{data($trip/id)}</TID>
        <AID>{data($album/id)}</AID>
        <CID>{data($content/id)}</CID>
        <URL>{data($content/url)}</URL>
        <TYPE>{data($content/type)}</TYPE>
      </tuple>
  }</CONTENT>
  
  <RATETRIP>{
    for $user at $index in doc($fpath) / tripster / user
    for $rating in $user/rateTrip
    return
      <tuple>
        <TID>{data($rating/tripid)}</TID>
        <USERID>{data($index)}</USERID>
        <RATING>{data($rating/score)}</RATING>
        <TEXT>{data($rating/comment)}</TEXT>
      </tuple>
  }</RATETRIP>
  
  <COMMENTCONTENT>{
    for $user at $index in doc($fpath) / tripster / user
    for $rating in $user/rateContent 
    for $trip in $user/trip [album/content/id = $rating/contentid]
    for $album in $trip/album [content/id = $rating/contentid]
    return
      <tuple>
        <TID>{data($trip/id)}</TID>
        <AID>{data($album/id)}</AID>
        <CID>{data($rating/contentid)}</CID>
        <USERID>{data($index)}</USERID>
        <TXT>{data($rating/comment)}</TXT>
      </tuple>
  }</COMMENTCONTENT>
  
  <ITEMS></ITEMS>
</database>
