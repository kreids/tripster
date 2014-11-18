for $user in doc("MyImportExport/G18_export.xml") /database/USERS/tuple
for $trip in doc("MyImportExport/G18_export.xml") /database/TRIP/tuple
for $album in  doc("MyImportExport/G18_export.xml")/database/ALBUM 
return
 <tripster>
	<user>
		<login>TODO</login>
		<email>TODO</email>
		<name>{data($user/NAME)}</name>
	  	<affiliation>{data($user/AFFILIATION)}</affiliation>
		<interests>da fuq?</interests>
		<friends>TODO</friends>
    <trip>
      <id>{data($trip/TID)}</id>
      <name>TODO</name>
      <feature>da fuq?</feature>
      <privacyFlag>TODO</privacyFlag>
      <album>TODO</album>
    </trip>
	</user>
</tripster>
