xquery version "1.0-ml";

module namespace c = "http://marklogic.com/roxy/controller/load";

(: the controller helper library provides methods to control which view and template get rendered :)
import module namespace ch = "http://marklogic.com/roxy/controller-helper" at "/roxy/lib/controller-helper.xqy";

import module namespace loadTriples = "http://marklogic.com/roxy/models/loadTriples" at "/app/models/loadTriples-lib.xqy";

declare option xdmp:mapping "false";

declare function c:triples() as item()*
{
	let $filePath := "C:\worksapce\ml-etymological\content\final\"
	let $load :=  loadTriples:load($filePath)
	let $amount := $load/amount
	let $directories := fn:string-join($load/directories/directory, ", ")
	return
	(
	  ch:add-value("title", "Load triple content"),
	  ch:add-value("path", $filePath),
	  ch:add-value("amount", $amount),
	  ch:add-value("directories", $directories),
	  ch:use-view((), "xml"),
	  ch:use-layout((), "xml")
	)
};

declare function c:meta() as item()*
{
	let $load :=  loadTriples:meta()
	return
	(
	  ch:add-value("title", "Adding Meta To triples"),
	  ch:use-view((), "xml"),
	  ch:use-layout((), "xml")
	)
};