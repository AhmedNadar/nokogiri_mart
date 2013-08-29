
require 'rubygems'
require 'open-uri' # for downloading web pages
require 'nokogiri' # for parsing HTML

# create a new HTML file to write the HTML to

File.open('movies.html', 'w') do |f|

	title = "Currently playing movies, via the Toronto Star"

	# start HTML file
	# include the title in the HTML title and on the page itself
	f.puts("<!DOCTYPE html>")
	f.puts("<html lang=\"en\">")
	f.puts("<head>")
	f.puts("\t<meta charset=\"utf-8\" />")
	f.puts("\t<title>#{title}</title>")
	f.puts("</head>")
	f.puts("<body>")
	f.puts("\t<h1>#{title}</h1>")

	raw_page = open("http://www.toronto.com/movies/now-playing/")
	page = Nokogiri::HTML(raw_page)

	# select the data we want from the page using a CSS selector
	movies = page.css(".preview h3 a")

	f.puts("\t<ul>")

	movies.each do |movie|
		f.puts("\t\t<li>#{movie}</li>")
	end

	f.puts("\t</ul>")

	f.puts("</body>")
	f.puts("</html>")
end
