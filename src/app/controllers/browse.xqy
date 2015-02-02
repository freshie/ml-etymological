xquery version "1.0-ml";

module namespace c = "http://marklogic.com/roxy/controller/browse";

import module namespace ch = "http://marklogic.com/roxy/controller-helper" at "/roxy/lib/controller-helper.xqy";
import module namespace req = "http://marklogic.com/roxy/request" at "/roxy/lib/request.xqy";

import module namespace browse = "http://marklogic.com/roxy/models/browse" at "/app/models/browse-lib.xqy";

declare option xdmp:mapping "false";

declare function c:main() as item()*
{
	let $letter := req:get('letter', "allow-empty=false", "ALL")
	let $model := browse:get($letter)
	return
	(
		ch:add-value("letters", $model/letters/letter),
		ch:add-value("title", "Browse"),
		ch:use-view((), "xml"),
		ch:use-layout((), "xml")
	)
};