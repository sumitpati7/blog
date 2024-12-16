require 'dotenv/load'
require 'trello'
require 'pry'

module Jekyll
  class ContentCreatorGenerator < Generator
    safe true
    ACCEPTED_COLOR = "green"

    def setup
      @trello_api_key = ENV['TRELLO_API_KEY']
      @trello_token = ENV['TRELLO_TOKEN']

      puts @trello_api_key

      Trello.configure do |config|
        config.developer_public_key = @trello_api_key
        config.member_token = @trello_token
      end
    end

    def generate(site)
      setup
      cards = Trello::List.find("675929a3f63a634e40a6b169").cards
      cards.each do |card|
        flashcards = ""
        # binding.pry
        due_on = card.due&.to_date.to_s
        slug = card.name.split.join("-").downcase
        created_on = DateTime.strptime(card.id[0..7].to_i(16).to_s, '%s').to_date.to_s
        article_date = due_on.empty? ? created_on : due_on
        flash_cards = Trello::List.find("675fcd452ff58169ebd0962c").cards
        flash_cards.each do |flash_card|
          flash_card_labels = []
          # binding.pry
          flash_card_labels = flash_card.labels.map { |label| label.name}
          flash_card_labels=flash_card_labels.uniq
          if flash_card_labels.include?(card.name)
            flashcards+= """
  - question: """ + flash_card.name + """
    answer: """ + flash_card.desc + """
            """
          end
        end
        content = """---
layout: post
title: """+card.name+"""
date: """+article_date+"""
flashcards: """ + flashcards + """
---

"""+card.desc+"""
        """
        file = File.open("./_posts/"+article_date+"-"+slug+".md","w+") { |f| f.write(content) }
        # binding.pry
      end
    end
  end
end
