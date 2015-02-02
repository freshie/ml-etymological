xquery version "1.0-ml";

module namespace m = "http://marklogic.com/roxy/models/loadTriples";

declare namespace dir = "http://marklogic.com/xdmp/directory";

declare function load(
	$filePath as xs:string
) as element() {
	let $directories := (xdmp:filesystem-directory($filePath)/dir:entry/dir:filename/xs:string(.)[fn:not(fn:ends-with(., ".xqy"))])
	return
		<load>
			<directories>
				{
					for $directory in $directories
						let $load := xdmp:spawn("/tasks/loadTriplesFromDirectory.xqy", (xs:QName("directory"), $filePath || $directory || "\"))
					return
						<directory>{$directory}</directory>
				}
			</directories>
			<amount>{fn:count($directories)}</amount>
		</load>
};

declare function meta()
as element()* {
	let $count := fn:count(cts:triples( (), (sem:iri("rdfs:label")), (), (), ("order-sop")))
	let $perTransationLimit := 1000
	let $numberOfTasks := fn:ceiling($count div $perTransationLimit)
	for $task at $index in (1 to $numberOfTasks)
		let $start :=
		  if ($index eq 1)
		  then
		    1
		  else
		    $index * $perTransationLimit
		let $end := $start + ($perTransationLimit - 1)
		let $load := xdmp:spawn("/tasks/addMetaDataToTriples.xqy", (xs:QName("start"), $start, xs:QName("end"), $end))
	return
		()
};