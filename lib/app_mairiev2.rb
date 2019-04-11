require 'open-uri'
require 'nokogiri'
require 'pry'
require 'open-uri'    

def connexion_page
        $doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
        return $doc
    end    

def get_townhall_email
        email_marie_albeiges = $doc.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
        puts email_marie_albeiges.text    
end    

def get_townhall_urls    #On récupère le nom des mairies
        array_maries = []
        $doc.xpath("//td/p/a").each do |mairie|
            array_maries << mairie.text.downcase
        end    #En fonction de leur nom, on récupère leur URL
        array_url = []
        array_maries.each do |url|
            url = url.gsub(/[' ']/, '-')
            array_url << "http://annuaire-des-mairies.com/95/#{url}.html"
        end    #On crée un array rempli avec des hashs (composés de nos deux array)
        array_finale = []
        array_maries.count.times do |index|
            array_finale << {array_maries[index] => array_url[index]}
        end
        puts array_finale.inspect
    end 


connexion_page
get_townhall_urls
