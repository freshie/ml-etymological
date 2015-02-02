let $loop := (1 to 5683)
for $i in $loop
  let $_ := xdmp:spawn("/transform.xqy", (xs:QName("i"), xs:string($i)))
return ()
