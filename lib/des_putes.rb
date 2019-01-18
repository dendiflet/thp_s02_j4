puts "\e[H\e[2J"    #clear le terminal


require 'pry'
require 'nokogiri'
require 'open-uri'

base__url_page = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"








def deputy
node = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")

		node.class('li')['href']
		asd = []
		aze.each{|link| mails << "http://www2.assemblee-nationale.fr#{link['href'].to_s}"}
puts mails
end


deputy







































