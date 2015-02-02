xquery version "1.0-ml";

declare variable  $triple as sem:triple  external;

let $subject := sem:triple-subject($triple)
let $objectLang := (sem:triple-object($triple) ! rdf:langString-language(.), "eng")[1] 
let $uri := fn:replace($subject, "https://github.com/freshie/", "/")
let $directory := "C:/worksapce/ml-etymological/content/final/" || $objectLang
  
let $triples := 
  <sem:triples>
    {cts:triples( $subject, (), (), (), ("order-sop"))}
  </sem:triples>
let $_ :=
  (: 
    Checks to see if the directory  exists
    if it doesnt then it will create it
  :)
  if (xdmp:filesystem-file-exists($directory))
  then ()
  else  xdmp:filesystem-directory-create($directory) 

let $_ := 
    xdmp:save("C:/worksapce" || $uri || ".xml", $triples,
    <options xmlns="xdmp:save">
      <output-encoding>utf-8</output-encoding>
    </options>)
    
let $_ := xdmp:log ("Finished converting file: " || $uri)
return 
  $triples