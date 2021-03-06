<tripster>
  <operator>CIS550</operator>
  <web_url>www.tripster.com</web_url>{
let $fpath := "G18_export.xml"
for $user in doc($fpath) /database/USERS/tuple
let $wenton := doc($fpath)/database/WENTON/tuple[USERID = $user/USERID]
let $invited := doc($fpath)/database/INVITE/tuple[INVITER = $user/USERID]

return
   <user>
   <login>{data($user/EMAIL)}</login>
   <email>{data($user/EMAIL)}</email>
   <name>{data($user/NAME)}</name>
   <affiliation>{data($user/AFFILIATION)}</affiliation>
   <interests>none</interests>
   {

       for $friends in doc($fpath)/database/FRIEND/tuple
       let $users := doc($fpath)/database/USERS/tuple[USERID != $user/USERID]
       where ($user/USERID = $friends/FRIEND1 or $user/USERID = $friends/FRIEND2)
       return if( $user/USERID = $friends/FRIEND1)
     
       then <friend>{ data($users[USERID = $friends/FRIEND2]/EMAIL)}</friend>
       else <friend> {data($users[USERID = $friends/FRIEND1]/EMAIL)}</friend> 

   }
   {
     for $trip in doc($fpath)/database/TRIP/tuple
     where $user/USERID = $trip/USERID
     return
       <trip>
         <id>{data($trip/TID)}</id>
         <name>{data($trip/NAME)}</name>
         <feature>none</feature>
         <privacyFlag>{data($trip/PRIVACY_FLAG)}</privacyFlag>
         {
           for $album in doc($fpath)/database/ALBUMS/tuple[TID = $trip/TID]
           return
             <album>
               <id>{data($album/AID)}</id>
               <name>{data($album/NAME)}</name>
               <privacyFlag>{data($album/PRIVACY_FLAG)}</privacyFlag>
               {
   
                for $cont in doc($fpath)/database/CONTENT/tuple[AID = $album/AID]
                where $cont/TID = $trip/TID
                return 
                 <content>
                   <id>{data($cont/CID)}</id>
                   <source>18</source>
                   <type>{data($cont/TYPE)}</type>
                   <url>{data($cont/URL)}</url>
                 </content>
               }
           </album>  
         }
         <location>
           <name>{data($trip/LOCATION)}</name>
           <type>place</type>         
         </location>
     </trip>
   }
   {
     for $rating in doc($fpath)/database/RATETRIP/tuple[USERID = $user/USERID]
     return
       <rateTrip>
         <tripid>{data($rating/TID)}</tripid>
         <score>{data($rating/RATING)}</score>
         <comment>{data($rating/TEXT)}</comment>
       </rateTrip>
   }
   {
      for $invited in doc($fpath)/database/INVITE/tuple
      where $invited/INVITER = $user/USERID
      return 
        <invite>
           <tripid>{data($invited/TID)}</tripid>
           {
             let $friendz := doc($fpath)/database/USERS/tuple[USERID = $invited/INVITEE]
             return  <friendid>{data($friendz/EMAIL)}</friendid>
           }
          
           <status>pending</status>
        </invite>
   }
 </user>
}</tripster>
