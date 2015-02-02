xquery version "1.0-ml";

import module namespace vh = "http://marklogic.com/roxy/view-helper" at "/roxy/lib/view-helper.xqy";

declare option xdmp:mapping "false";

<div>
	<p>
		Loading triple from {vh:get('amount')} directories at this path {vh:get("path")}
	</p>
	<p><strong>directories</strong>: {vh:get('directories')}</p>
</div>