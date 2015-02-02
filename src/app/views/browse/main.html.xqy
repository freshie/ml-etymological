xquery version "1.0-ml";

import module namespace vh = "http://marklogic.com/roxy/view-helper" at "/roxy/lib/view-helper.xqy";

declare option xdmp:mapping "false";
<div>
	<div class="row">
		<div class="col-lg-4">
			<form class="form-inline" method="get" action="/browse/">
				<p>
					<select name="letter" class="form-control">
						{
							for $letter in vh:get('letters')
								let $name := $letter/name/xs:string(.)
							return
								if ($letter/selected/xs:boolean(.))
								then <option value="{$name}" selected="selected">{$name}</option>
								else <option value="{$name}">{$name}</option>
						}
					</select>
				</p>
				<p>
					<button class="btn btn-default" type="submit">Filter</button>
				</p>
			</form>
		</div>
		<div class="col-lg-8">
			<!-- First column -->
			<ul class="list-group">
				<li class="list-group-item">
					<h4>
						<a href="/etymological/?s=[subjectIRI]">[label]</a>
					</h4>
					<h6 class="text-muted">
						<em>[path+]</em>
					</h6>
				</li>
			</ul>
		</div>
	</div>
</div>