puts "\e[H\e[2J"    #clear le terminal
require 'pry'
require 'nokogiri'
require 'open-uri'

def all_dep					#ici c'est bon
	scrappagetotal = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/"))
	
	#selectionne les liens du corp de page avec la class "lientxt"
	dep_links_dirty = scrappagetotal.css("tbody").css("a").select{|link| link['class'] == "lientxt"}

	mails_each_dep = []			
	
	#création de l'array de mails + mise en forme des mails
	dep_links_dirty.each{|link| mails_each_dep << "https://www.annuaire-des-mairies.com/#{link['href'].to_s}"}

	#print mails_each_dep 		#ok

	return mails_each_dep
end



def true_city_mail_list(dep_city_list_page) 
  dep_pages_full_list = []												#création de l'array vide
	dep_city_list_page.each do |mail|								#loop avec chaque page de la liste des departements
		page_exist = check_page(mail)									#verif de la 1ere
		
		puts "#{mail}"																#j'ai bien la 1ere adresse
		puts "page_exist vaut #{page_exist} comme pas prévu"   #ne s'affiche pas

		if page_exist == true 							#verif du mail donné <-tjrs true car 1ere donc set page exist = true
		
		puts "page_exist vaut toujours #{page_exist} !"
		puts "ici c'est bon"					
		puts "normalement ici il doit afficher que c'est un string ...#{mail.class}"
		puts "ici je vais enregistrer le mail temporaire dans la nouvelle liste"			

		dep_pages_full_list << mail 									#ajout a la liste complete

		puts "il devrait afficher la noouvelle liste en dessous"
		print dep_pages_full_list

		end
		#puts "tu va t\'afficher bordel #{dep_pages_full_list} ! !! ! "

		i = 1																		#les pages supp commencent an -2.html
		
		while page_exist != false  do			#normalement setté a true par la précedente vérif
			i = i + 1 													#iteration pour la prochaine verif
			temp_dep_mail = ""
			temp_dep_mail = "#{mail.slice(0..-6)}-#{i}.html"		#modificaton du mail d'origine
			page_exist = check_page(temp_dep_mail)									#fait tourner pour voir si la page existe
			if page_exist == true 									#si la page existe ajout a la liste
				dep_pages_full_list << temp_dep_mail		
			end
		end
		
	end

	return dep_pages_full_list
end



def check_page(url_to_check)
	begin
    open(url_to_check)
  rescue OpenURI::HTTPError
    page_exist = false
    puts page_exist
    return
  end
  	page_exist = true
  	puts page_exist
  return
end



def perform
	dep_city_list_page = all_dep			#recherche des mails de chaque departements
	puts "ici c'est le nb de page de departement avant moulinette #{dep_city_list_page.length} "
	
	dep_pages_full_list = true_city_mail_list(dep_city_list_page)			#il y avait plusieurs pages de communes ;-)
	puts "ici c'est le nb de page de departement apres moulinette #{dep_pages_full_list.length} "

end



full_list = perform
#print full_list








