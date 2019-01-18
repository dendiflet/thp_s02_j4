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

	print mails_each_dep

	return mails_each_dep
end



def true_city_mail_list(dep_city_list_page)
 
  dep_pages_full_list = []												#création de l'array vide

	dep_city_list_page.each do |mail|								#loop avec chaque page de la liste des departements

		page_exist = check_page(mail)									#verif de la 1ere
		
		puts "#{mail}"																#j'ai bien la 1ere adresse
		puts "page_exist vaut #{page_exist} comme prévu"   #ne s'affiche pas


		if page_exist == true 							#verif du mail donné <-tjrs true car 1ere donc set page exist = true
		
		puts "page_exist vaut toujours #{page_exist} !"
		puts "ici c'est bon"					
		puts "normalement ici il doit afficher que c'est un string ...#{mail.class}"
		puts "ici je vais enregistrer le mail temporaire dans la nouvelle liste"			


			dep_pages_full_list << mail 									#ajout a la full_list


		puts "il devrait afficher la noouvelle liste en dessous"
		print dep_pages_full_list


			
		end
		#puts "tu va t\'afficher bordel #{dep_pages_full_list} ! !! ! "

		i = 2																			#les pages supp commencent an -2.html
		
		#until page_exist == false do	
		while page_exist != false  do		
			temp_dep_mail = ""
			temp_dep_mail = "#{mail.slice(0..-6)}-#{i}.html"		#modificaton du mail d'origine

			page_exist = check_page(temp_dep_mail)									#fait tourner pour voir si la page existe

			if page_exist == true 									#si la page existe ajout a la liste
				dep_pages_full_list << temp_dep_mail		
				i = i + 1 													#iteration pour la prochaine verif
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
    puts page_exist
    return
  end
  	page_exist = true
  	puts page_exist
  return
end


# def check_page(url)
# 	begin
#     open(url)
#   	rescue Errno::ENOENT
#     	page_exist = false
#     return
#   	page_exist = true
#   	end

#   puts "la je suis dans checkpage et page_existe devrait etre setté a #{page_exist}   <---- true"
#   return
# end

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
	dep_city_list_page = all_dep			#recherche des mails de chaque departements
	puts "ici c'est le nb de page de departement avant moulinette #{dep_city_list_page.length} "
	
	# dep_pages_full_list = true_city_mail_list(dep_city_list_page)			#il y avait plusieurs pages de communes ;-)
	# 	puts "ici c'est le nb de page de departement apres moulinette #{dep_pages_full_list.length} "


	# dep_pages_full_list.each do |dep_page|															#collecte des liens de chaque mairies avec une boucle pour chaque
	# 	full_city_page_list << collect_all_citys_page(dep_page)
	# end
	# puts "ca ---> #{full_city_page_list} c'est le nb de communes en france"


	# 	full_city_page_list.each do |city_page|															#collecte des liens de chaque mairies avec une boucle pour chaque
	# 	full_city_mails_list << collect_all_citys_mail(city_page)
	# end
	# return full_city_mails_list
end



full_list = perform
#print full_list








