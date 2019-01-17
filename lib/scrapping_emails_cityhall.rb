puts "\e[H\e[2J"    #clear le terminal

# le résult doit etre
# hash des emails des mairies du 95
# a = [
#   { "ville_1" => "email_1" },
#   { "ville_2" => "email_2" }, 
#   etc
# ]

#get_townhall_email(townhall_url)

require 'pry'
require 'nokogiri'
require 'open-uri'


def all_dep
	pays_doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/"))
end



#def all_commune

  departement_doc = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/vosges.html"))
  commune_list = departement_doc.css( "tr").css("a")
#.each{|link| puts link['href'] }

puts  commune_list


def city_mail
  city_doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/88/epinal.html"))
	cty_twnhall = city_doc.xpath("//tbody/tr[4]/td[2]")
	print cty_twnhall
	city_mail = cty_twnhall.select { |v| v =~ /[@]/ }
end

#city_mail

