xquery version "1.0-ml";

import module namespace sem = "http://marklogic.com/semantics" at "/MarkLogic/semantics.xqy";

declare variable $start as xs:int external;
declare variable $end as xs:int external;

let $loop := ($start to $end)
let $triples := cts:triples( (), (sem:iri("rdfs:label")), (), (), ("order-sop"))[$loop]
for $triple in $triples
	let $subject := sem:triple-subject($triple)
	let $object := sem:triple-object($triple)
	let $lang := rdf:langString-language($object)
	let $firstLetter := fn:substring($object, 1,1)
	let $xml :=
	 (
	  <sem:triple xmlns:sem="http://marklogic.com/semantics">
	    <sem:subject>{$subject}</sem:subject>
	    <sem:predicate>https://github.com/freshie/ml-etymological/firstLetterIs</sem:predicate>
	    <sem:object datatype="http://www.w3.org/2001/XMLSchema#string">{$firstLetter}</sem:object>
	  </sem:triple>,
	  <sem:triple xmlns:sem="http://marklogic.com/semantics">
	    <sem:subject>{$subject}</sem:subject>
	    <sem:predicate>xml:lang</sem:predicate>
	    <sem:object datatype="http://www.w3.org/2001/XMLSchema#string">{$lang}</sem:object>
	  </sem:triple>
	  )
	let $load := sem:triple($xml) ! sem:rdf-insert(., (), (xdmp:permission("ml-etymological-role", "read"), xdmp:permission("ml-etymological-role", "update"), xdmp:permission("ml-etymological-role", "insert")))
return xdmp:log ("added meta data for " || $lang || " for " || $object)