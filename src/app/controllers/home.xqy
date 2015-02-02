xquery version "1.0-ml";

module namespace c = "http://marklogic.com/roxy/controller/home";

(: the controller helper library provides methods to control which view and template get rendered :)
import module namespace ch = "http://marklogic.com/roxy/controller-helper" at "/roxy/lib/controller-helper.xqy";

declare option xdmp:mapping "false";

declare function c:main() as item()*
{
  ch:use-view((), "xml"),
  ch:use-layout((), "xml")
};
