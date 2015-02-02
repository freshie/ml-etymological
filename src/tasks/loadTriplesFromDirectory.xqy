xquery version "1.0-ml";

declare namespace dir = "http://marklogic.com/xdmp/directory";

declare variable $directory as xs:string external;
let $files := xdmp:filesystem-directory($directory)/dir:entry/dir:filename/xs:string(.)
let $count := fn:count($files)
let $perTransationLimit := 1000
let $numberOfTasks := fn:ceiling($count div $perTransationLimit)
let $spawn :=
	for $task at $index in (1 to $numberOfTasks)
		let $start :=
		  if ($index eq 1)
		  then
		    1
		  else
		    $index * $perTransationLimit
		let $end := $start + ($perTransationLimit - 1)
		let $filesToCover :=
	     <files>
	     {
	       for $file in $files[$start to $end]
	       return <file>{$file}</file>
	     }
	     </files>
	where fn:exists($filesToCover)
	return
		xdmp:spawn("/tasks/loadTriplesFromFiles.xqy", (xs:QName("files"), $filesToCover, xs:QName("directory"), $directory))
return xdmp:log ("spawn " || $numberOfTasks || " for " || $directory)