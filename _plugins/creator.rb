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
                due_on = card.due&.to_date.to_s
                slug = card.name.split.join("-").downcase
                created_on = DateTime.strptime(card.id[0..7].to_i(16).to_s, '%s')
                article_date = due_on.empty? ? created_on : due_on
                content = """---
                layout: post
                title: #{card.name}
                date: #{article_date}
                ---

                #{card.desc}
                """
                file = File.open("./_posts/#{article_date}-#{slug}.md","w+") { |f| f.write(content) }
            end
        end
    end
end

