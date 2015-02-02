xquery version "1.0-ml";

declare namespace dir = "http://marklogic.com/xdmp/directory";

import module namespace sem = "http://marklogic.com/semantics" at "/MarkLogic/semantics.xqy";

declare variable $directory as xs:string external;
declare variable $files as element(files) external;

for $file in $files/file/xs:string(.)
	let $fileWIthPath := $directory || $file
	let $triples :=  xdmp:unquote(xdmp:filesystem-file($fileWIthPath))/sem:triples/sem:triple
	let $count := fn:count($triples)
	let $load :=
		for $triple in $triples
		return sem:triple($triple) ! sem:rdf-insert(., (), (xdmp:permission("ml-etymological-role", "read"), xdmp:permission("ml-etymological-role", "update"), xdmp:permission("ml-etymological-role", "insert")))

return xdmp:log ("loaded  " || $count || " from " || $fileWIthPath)