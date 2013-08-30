require 'rubygems'
require 'nokogiri'
require 'open-uri'

File.open("walmart.html", 'w') do |f|

	url = "http://www.walmart.ca/canada-estore/search/searchcontainer.jsp?&addFacet=SRCH%3Aapple&trail=&searchString=apple&pageNo=0&startPageNo=1&resultsInPage=30&sortMode=&sortProperty=&sortOrder=/canada-estore/search/searchcontainer.jsp?&addFacet=SRCH%3Aapple&trail=&searchString=apple&pageNo=0&startPageNo=1&resultsInPage=30&sortMode=&sortProperty=&sortOrder=&startSearch=yes&compare=&_requestid=45012"
	doc = Nokogiri::HTML(open(url))
	page_title = doc.at_css("title").text
f.puts <<-eos

	<!DOCTYPE html>
	<html lang="en">
	  <head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta name="description" content="">
	    <meta name="author" content="">
	    <link rel="shortcut icon" href="assets/ico/favicon.png">

	    <title>Fun with Nokogiri and Bootstrap</title>

	    <!-- Bootstrap core CSS -->
	    <link href="assets/css/bootstrap.css" rel="stylesheet">
	    <link rel="stylesheet" type="text/css" href="style.css">

	    <!-- Custom styles for this template -->
	    <link href="assets/css/justified-nav.css" rel="stylesheet">

	    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	    <!--[if lt IE 9]>
	      <script src="assets/js/html5shiv.js"></script>
	      <script src="assets/js/respond.min.js"></script>
	    <![endif]-->
	  </head>
	  <body>
	    <div class="container">
	      <div class="masthead">
	        <h3 class="text-muted">Walmart by Nokogiri</h3>
	         <ul class="nav nav-justified">
	           <li class="active"><a href="#">Home</a></li>
	           <li><a href="http://www.bitmakerlabs.com/">Bitmaker Labs</a></li>
	           <li><a href="https://github.com/AhmedNadar">Github</a></li>
	           <li><a href="https://twitter.com/AhmedNadar">Twitter</a></li>
	           <li><a href="http://pinterest.com/ahmednadar/">Pinterest</a></li>
	         </ul>
	      </div>
	      <!-- Jumbotron -->
	      <div class="jumbotron">
	        <h1>Fun with Nokogiri and Bootstrap</h1>
	        <p class="lead">Fetch for Apple products from Walmart.com using Nocogiri</p>
	        <p><a class="btn btn-lg btn-success" href="https://github.com/AhmedNadar/store_list_by_nokogiri">Get the repo</a></p>
	      </div>
eos
	doc.css(".hproduct").each do |item|
		product_name = item.at_css("#view-product-details a").text
		product_link = item.at_css("#view-product-details a")[:href]
		product_image = item.at_css("#view-product-image img")[:src]
		product_image_alt = item.at_css("#view-product-image img")[:alt]
		price = item.at_css(".original-price").text[/\$[0-9\.]+/]
		f.puts("<div class=\"row\">")
			f.puts("<div class=\"col-lg-3 box3_extra_style product_bottom_border\">")
				f.puts("<h4>#{product_name}</h4>")
			   f.puts("<img class=\"img\" src=\"#{product_image}\" alt=\"#{product_image_alt}\">")
			   f.puts("<p>#{price}</p>")
	   		f.puts("<p><a class=\"btn btn-primary\" href=\"#{product_link}\">View details &raquo;</a></p>")
	      f.puts("</div>")
	       
			f.puts("<div class=\"col-lg-3 box3_extra_style product_bottom_border\">")
				f.puts("<h4>#{product_name}</h4>")
			   f.puts("<img class=\"img\" src=\"#{product_image}\" alt=\"#{product_image_alt}\">")
			   f.puts("<p>#{price}</p>")
			   f.puts("<p><a class=\"btn btn-primary\" href=\"#{product_link}\">View details &raquo;</a></p>")
	      f.puts("</div>")

			f.puts("<div class=\"col-lg-3 box3_extra_style product_bottom_border\">")
				f.puts("<h4>#{product_name}</h4>")
			   f.puts("<img class=\"img\" src=\"#{product_image}\" alt=\"#{product_image_alt}\">")
			   f.puts("<p class=\"price\">#{price}</p>")
	   		f.puts("<p><a class=\"btn btn-primary\" href=\"#{product_link}\">View details &raquo;</a></p>")
	      f.puts("</div>")
	      f.puts("</div>")
	end
f.puts <<-eos
	      <!-- Site footer -->
	      <div class="footer">
	        <p>&copy; Ahmed Nadar 2013</p>
	      </div>
	    </div> <!-- /container -->
	    <!-- Bootstrap core JavaScript
	    ================================================== -->
	    <!-- Placed at the end of the document so the pages load faster -->
	  </body>
	</html>
eos
end

