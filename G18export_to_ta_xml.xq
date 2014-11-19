<tripster>{
let $fpath := "MyImportExport/G18_export.xml"
for $user in doc($fpath) /database/USERS/tuple
let $wenton := doc($fpath)/database/WENTON/tuple[USERID = $user/USERID]
let $invited := doc($fpath)/database/INVITE/tuple[INVITER = $user/USERID]

return
   <user>
   <name>{data($user/NAME)}</name>
   <login>{data($user/EMAIL)}</login>
   <email>{data($user/EMAIL)}</email>
   <affiliation>{data($user/AFFILIATION)}</affiliation>
   <interests>NULL</interests> 
   {
        for $friends in doc($fpath)/database/FRIEND/tuple
        let $users := doc($fpath)/database/USERS/tuple[USERID != $user/USERID]
        where ($user/USERID = $friends/FRIEND1 or $user/USERID = $friends/FRIEND2)
        return if( $user/USERID = $friends/FRIEND1)
        then <friend>{ data($users[USERID = $friends/FRIEND2]/NAME)}</friend>
        else <friend> {data($users[USERID = $friends/FRIEND1]/NAME)}</friend>  
   }
   {
     for $trip in doc($fpath)/database/TRIP/tuple
     where $wenton/TID = $trip/TID
     return
       <trip>
         <id>{data($trip/TID)}</id>
         <name>{data($trip/NAME)}</name>
         <feature>TODO?</feature>
         <privacyFlag>{data($trip/PRIVACY_FLAG)}</privacyFlag>
        
         {
           for $album in doc($fpath)/database/ALBUMS/tuple[TID = $trip/TID]
           return
             <album>
               <id>{data($album/AID)}</id>
               <name>{data($album/NAME)}</name>
               <privacyFlag>{data($album/PRIVACY_FLAG)}</privacyFlag>
               {
                  (:photo content:)
                for $photo in doc($fpath)/database/PHOTOS/tuple[AID = $album/AID]
                where $photo/TID = $trip/TID
                return 
                 <content>
                   <id>{data($photo/PID)}</id>
                   <source>todo?</source>
                   <type>photo</type>
                   <url>{data($photo/URL)}</url>
                 </content>
               }
               {
                  (:video content:)
                for $video in doc($fpath)/database/VIDEO/tuple[AID = $album/AID]
                where $video/TID = $trip/TID
                return 
                 <content>
                   <id>{data($video/PID)}</id>
                   <source>todo?</source>
                   <type>video</type>
                   <url>{data($video/URL)}</url>
                 </content>
               }
             </album>
             
         }
         <location>{data($trip/LOCATION)}</location>
       </trip>
   }
   {
      for $invited in doc($fpath)/database/INVITE/tuple
      where $invited/INVITER = $user/USERID
      return 
        <invite>
           <tripid>{data($invited/TID)}</tripid>
           <friendid>{data($invited/INVITEE)}</friendid>
           <status>PENDING</status>
        </invite>
   }
   {
     for $rating in doc($fpath)/database/RATETRIP/tuple
     return
       <rateTrip>
         <tripid>{data($rating/TID)}</tripid>
         <score>{data($rating/RATING)}</score>
         <comment>TODO</comment>
       </rateTrip>
   }
   </user>
}</tripster>
