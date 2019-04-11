	require 'open-uri'
	require 'nokogiri'
	require 'pry'
	require 'open-uri'

	def connexion_page
		$doc = Nokogiri::HTML(open("https://www.mortchoisie.org/guide-pratique/d%C3%A9put%C3%A9s/index.html"))
		return $doc
	end

	def emails_députés
		array_emails = []
		$doc.xpath("//tr/td[3]/p/span/a").each do |email|
			array_emails << email.text
		end
		return array_emails
	end


	def email_to_first_name(array_emails)
		first_name_array = []

		array_emails.each do |email|
			first_name = email[/[^@]+/].capitalize
			first_name_array << first_name.split(".").slice(0)
		end
		return first_name_array
	end

	def email_to_last_name(array_emails)
		last_name_array = []

		array_emails.each do |email|
			last_name = email[/[^@]+/]
			last_name = last_name.split(".")
			last_name = last_name.map!(&:capitalize)
			last_name_array << last_name.slice(1)
		end
		return last_name_array
	end

	def perform
		array_emails = emails_députés
		first_name_array = email_to_first_name(array_emails)
		last_name_array = email_to_last_name(array_emails)

		array_finale = []

		array_emails.count.times do |index|
			array_finale << {
				"first_name" => first_name_array[index],
				"last_name" => last_name_array[index],
				"email" => array_emails[index]
			}
		end
		puts array_finale
		return array_finale
	end

	connexion_page
perform