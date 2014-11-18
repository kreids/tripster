for $user in doc("MyImportExport/G18_export.xml") /database/USERS/tuple
return
 <tripster>
	<user>
		<login>TODO</login>
		<email>TODO</email>
		<name>{data($user/NAME)}</name>
		<affiliation>{data($user/AFFILIATON)}</affiliation>
		<interests>WUTINTHEWUT</interests>
		<friends>I HAVE NO FRIENDS =(</friends>
	</user>
</tripster>
