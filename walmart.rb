require 'rubygems'
require 'nokogiri'
require 'open-uri'

File.open("walmart.html", 'w') do |f|

	url = "http://www.walmart.ca/canada-estore/search/searchcontainer.jsp?&addFacet=SRCH%3Aapple&trail=&searchString=apple&pageNo=0&startPageNo=1&resultsInPage=30&sortMode=&sortProperty=&sortOrder=/canada-estore/search/searchcontainer.jsp?&addFacet=SRCH%3Aapple&trail=&searchString=apple&pageNo=0&startPageNo=1&resultsInPage=30&sortMode=&sortProperty=&sortOrder=&startSearch=yes&compare=&_requestid=45012"
	doc = Nokogiri::HTML(open(url))
	page_title = doc.at_css("title").text

	f.puts("<!DOCTYPE html>")
	f.puts("<html>")
	f.puts("\t<head>")
	f.puts("\t<title>#{page_title}</title>")
	f.puts("<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">")
	f.puts("\t</head>")
	f.puts("<body>")
	f.puts("\t\t<h2>#{page_title}</h2>")
	f.puts("\t<div class=\"container\">")		
	f.puts("\t\t<ul>")		
		doc.css(".hproduct").each do |item|
			product_name = item.at_css("#view-product-details a").text
			product_link = item.at_css("#view-product-details a")[:href]
			price = item.at_css(".original-price").text[/\$[0-9\.]+/]
			# #print name and price in terminal
			# puts "#{product_name} -  #{price}"
			# puts "#{product_link}" 
			f.puts("\t<li class=\"name\">#{product_name}</li>")
			f.puts("\t<span class=\"price\">#{price}</span>")
			f.puts("\t<a class=\"link\" href=\"#{product_link}\">more details</a>")
		end
	f.puts("\t\t</ul>")
	f.puts("\t</div>")
	f.puts("</body>")
	f.puts("</html>")
end
