xquery version "1.0-ml";

module namespace m = "http://marklogic.com/roxy/models/browse";

declare function m:get(
	$letterIn as xs:string
) as element() {
	let $words := m:getWordsByFirstLetter($letterIn)
	return
		<model>
			<letters>
			{
				let $letters := ("ALL","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
				for $letter in $letters
				return
					<letter>
						<name>{$letter}</name>
						<selected>{$letterIn eq $letter}</selected>
					</letter>
			}
			</letters>
		</model>
};

declare function m:getWordsByFirstLetter(
	$letterIn as xs:string
) as element() {
	
};