xquery version "1.0-ml";

import module namespace sem = "http://marklogic.com/semantics" at "/MarkLogic/semantics.xqy";

declare variable $i as xs:string external;

let $baseURI := "https://github.com/freshie/ml-etymological/content/final/"

let $file := xdmp:filesystem-file("C:\worksapce\ml-etymological\content\split-out\disk" || $i || ".gsd")
let $lines := fn:tokenize($file, "\n","m")
let $triples :=
  for $line in $lines[fn:not(fn:normalize-space(.) eq (""," ",())) ]
    let $lineTokenized := fn:tokenize($line, "\t","s")
    let $subjectAndLang := fn:tokenize($lineTokenized[1], " ","s")
    let $subjectLang := fn:replace($subjectAndLang[1], ":", "")
    let $subject := $subjectAndLang[2]
    let $subjectIRI :=  $baseURI || $subjectLang || "/" || $subject
    let $predicate := fn:replace($lineTokenized[2], "rel:","")
    let $predicateIRI :=  $baseURI || "relationShips/" || $predicate
    let $objectAndLang := fn:tokenize($lineTokenized[3], " ","s")
    let $object := $objectAndLang[2]
    let $objectLang := fn:replace($objectAndLang[1], ":", "")
    let $objectIRI := $baseURI || $objectLang || "/" || $object
    where fn:not( ($subject,$object,$predicate) eq ("", " ", ()) )
  return
  (
   (: triple for their relationship :)
  sem:triple(sem:iri($subjectIRI),sem:iri($predicateIRI),sem:iri($objectIRI)),
   (: triple for the subject :)
  sem:triple(sem:iri($subjectIRI),sem:iri("rdfs:label"), rdf:langString($subject, $subjectLang) ),
   (: triple for the object :)
  sem:triple(sem:iri($objectIRI),sem:iri("rdfs:label"), rdf:langString($object, $objectLang) )
  )
let $_ := sem:rdf-insert($triples)
let $_ := xdmp:log ("Finished converting file: " || $i)
return $triples