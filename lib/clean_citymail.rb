puts "\e[H\e[2J"    #clear le terminal
#binding.pry

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




def all_commune

	scrappagetotal = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/vosges.html"))
	
	#selectionne les liens du corp de page avec la class "lientxt"
	news_links_dirty = scrappagetotal.css("tr").css("a").select{|link| link['class'] == "lientxt"}

	mails_each_city = []
	
	#création de l'array de mails + mise en forme des mails
	news_links_dirty.each{|link| mails_each_city << "https://www.annuaire-des-mairies.com/#{link['href'].to_s.slice!(1..-1)}"}

	#puts mails_each_city

end


def mail_citytwnhll

	city_doc_all = Nokogiri::HTML(open("http://annuaire-des-mairies.com/88/epinal.html"))
  
  cty_twnhall = city_doc_all.xpath("//tbody/tr[4]/td[2]")
  city_mail = []
  #transfo en string (car c'est encore un node), selectionne la bonne et clean car encore les <td>
  city_mail = cty_twnhall[0].to_s.slice(4...-5)										#.select { |v| v =~ /[@]/ } 

  puts city_mail


end


#mail_citytwnhll