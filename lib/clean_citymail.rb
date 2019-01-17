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

	scrappagetotal = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/"))
	
	#selectionne les liens du corp de page avec la class "lientxt"
	dep_links_dirty = scrappagetotal.css("tbody").css("a").select{|link| link['class'] == "lientxt"}

	mails_each_dep = []
	
	#création de l'array de mails + mise en forme des mails
	dep_links_dirty.each{|link| mails_each_dep << "https://www.annuaire-des-mairies.com/#{link['href'].to_s}"}
	#puts mails_each_dep

	return mails_each_dep
end

def true_city_mail_list(dep_base_list)

	dep_base_list.each do |mail|								#loop avec chaque mail de la liste

		if check_page(mail) == true 							#verif du mail donné <-tjrs true donc set page exist = true
			dep_pages_full_list << mail 									#ajout a la full_list
		end

		i = 2																			#les pages supp commencent an -2.html
		temp_dep_mail = ""

		until page_exist == false do		

			temp_dep_mail = dep_base_list.insert(-6;"-#{i}")		#modificaton du mail d'origine
			
			check_page(temp_dep_mail)									#fait tourner pour voir si la page existe
			
			if page_exist == true 									#si la page existe ajout a la liste
				dep_pages_full_list << temp_dep_mail
			i += 1 																	#iteration pour la prochaine verif
			end

		end
	end

	return dep_pages_full_list
end


def check_page(url)
	begin
    open(url)
  rescue OpenURI::HTTPError
    page_exist = false
    return
  end
  	page_exist = true
  return
end




def collect_all_citys_page()

	scrappagetotal = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/vosges.html"))
	
	#selectionne les liens du corp de page avec la class "lientxt"
	news_links_dirty = scrappagetotal.css("tr").css("a").select{|link| link['class'] == "lientxt"}

	mails_each_city_dep_page_list = []
	
	#création de l'array de mails + mise en forme des mails
	news_links_dirty.each{|link| mails_each_city_dep_page_list << "https://www.annuaire-des-mairies.com/#{link['href'].to_s.slice!(1..-1)}"}

	#puts mails_each_city_dep_page_list
	return mails_each_city_dep_page_list
end


def collect_all_citys_mail

	city_doc_all = Nokogiri::HTML(open("http://annuaire-des-mairies.com/88/epinal.html"))
  #va chercher a peux pres au bon endroit
  cty_twnhall = city_doc_all.xpath("//body/div/main/section[2]/div/table/tbody/tr[4]/td[2]") 		#ultra presci...
  #puts cty_twnhall


  city_mail = []
  #transfo en string (car c'est encore un node), ###selectionne la bonne####fini#### et clean car encore les <td>
  city_mail = cty_twnhall.to_s.slice(4...-5)										#### ceci ne fonctionne pas -->  .select { |v| v =~ /[@]/ } 
  
  #puts city_mail
  return city_mail
end

def perform
	city_list_page = all_dep			#recherche des mails de chaque departements
	
	dep_pages_full_list = true_city_mail_list(city_list_page)		#il y avait plusieurs pages de communes ;-)
	
	dep_pages_full_list.each do |dep_page|															#collecte des liens de chaque mairies avec une boucle pour chaque
		full_city_page_list << collect_all_citys_page(dep_page)
	end


		full_city_page_list.each do |city_page|															#collecte des liens de chaque mairies avec une boucle pour chaque
		full_city_mails_list << collect_all_citys_mail(city_page)
	end
	return full_city_mails_list

end

full_list = perform

print full_list








