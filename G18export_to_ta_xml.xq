<tripster>{
for $user in doc("MyImportExport/G18_export.xml") /database/USERS/tuple
let $wenton := doc("MyImportExport/G18_export.xml")/database/WENTON/tuple
return
   <user>
   <name>{data($user/NAME)}</name>
   <login>TODO</login>
   <email>TODO</email>
   <affiliation>{data($user/AFFILIATION)}</affiliation>
   <interests>NULL</interests> 
   {
        for $friends in doc("MyImportExport/G18_export.xml")/database/FRIEND/tuple
        let $users := doc("MyImportExport/G18_export.xml")/database/USERS/tuple[USERID != $user/USERID]
        where ($user/USERID = $friends/FRIEND1 or $user/USERID = $friends/FRIEND2)
        return if( $user/USERID = $friends/FRIEND1)
        then <friend>{ data($users[USERID = $friends/FRIEND2]/NAME)}</friend>
        else <friend> {data($users[USERID = $friends/FRIEND1]/NAME)}</friend>  
   }
   <trip>
     <id>
     {data($wenton[USERID = $user/USERID]/TID)}
     </id>
   </trip>
   
   </user>
}</tripster>
