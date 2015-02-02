let $triples := cts:triples( (), sem:iri("rdfs:label"), (), (), ("order-sop"))
for $triple in $triples
  let $_ := xdmp:spawn("/content/final/transform.xqy", (xs:QName("triple"), $triple))
return ()