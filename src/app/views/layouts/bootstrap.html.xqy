import module namespace vh = "http://marklogic.com/roxy/view-helper" at "/roxy/lib/view-helper.xqy";

declare variable $view as item()* := vh:get("view");
declare variable $title as xs:string? := (vh:get('title'), "Home")[1];

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
  <head xmlns="">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>MarkLogic Etymological: {$title}</title>
    <link href="/public/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/public/css/main.css" rel="stylesheet"/>
  </head>
  <body xmlns="">
    <nav class="navbar navbar-default " role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/">MarkLogic Etymological</a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse">
          <ul class="nav navbar-nav">
            <li>
              <a href="/">Home</a>
            </li>
            <li>
              <a href="/browse">Browse</a>
            </li>
            <li>
              <form action="/search/" method="get" class="navbar-form">
                <div class="scrollable-dropdown-menu">
                  <input type="text" name="keywords" value="" placeholder="Search" class="form-control typeahead"/>
                  <button class="hide" type="submit">Search</button>
                </div>
              </form>
            </li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <div class="container"><!-- view -->
      { $view }
    </div><!-- /view -->
  </body>
  <script type="text/javascript" xmlns="">
      var SITE = {{}};
  </script>
  <script type="text/javascript" src="/public/js/lib/bootstrap.min.js" xmlns=""></script>
  <script type="text/javascript" src="/public/js/typeahead.bundle.js" xmlns=""></script>
  <script type="text/javascript" src="/public/js/main.js" xmlns=""></script>
</html>