require 'twitter'
require 'dotenv'
require 'pry'
require 'nokogiri'
require 'open-uri'




Dotenv.load('.env')


# quelques lignes qui appellent les clés d'API de ton fichier .env
def connexion_page_html (cible = "https://www.mortchoisie.org/guide-pratique/d%C3%A9put%C3%A9s/index.html")
	$page = Nokogiri::HTML(open(cible))
	return $page

end

def scrap_nom_du_député

	#je récupère les emails
	$email_du_depute = []
	$page.xpath("//tr/td[3]/p/span/a").each do |email_depute|
		$email_du_depute << email_depute.text
	end

	puts $email_du_depute

	#je récupère le nom de famille
	$nom_du_depute = []
	$page.xpath("//*[@id=\"cc-m-12135508249\"]/table/tbody/tr[*]/td[2]/p/span").each do |nom_depute|

		$nom_du_depute << nom_depute.text
	end

	puts $nom_du_depute

	$prenom_du_depute = []
	$page.xpath("//*[@id=\"cc-m-12135508249\"]/table/tbody/tr[*]/td[2]/p/span").each do |prenom_depute|

		$prenom_du_depute << prenom_depute.text
	end



	array_finale = []

			$nom_du_depute.count.times do |index|
	        array_finale << {
	        	"first_name" => $prenom_du_depute[index],
	        	"last_name" => $nom_du_depute[index],
	        	"email" => $email_du_depute[index]
	        }
	    end    

 #      puts array_finale

 
end




connexion_page_html
scrap_nom_du_député