require 'dotenv/load'
require 'trello'
require 'pry'

module Jekyll
  class ContentCreatorGenerator < Generator
    safe true
    ACCEPTED_COLOR = "green" # unused in current code, consider removing if not needed

    def setup
      @trello_api_key = ENV['TRELLO_API_KEY']
      @trello_token = ENV['TRELLO_TOKEN']

      puts "Trello API Key: #{@trello_api_key}" # added context to output

      Trello.configure do |config|
        config.developer_public_key = @trello_api_key
        config.member_token = @trello_token
      end
    end

    def generate_index_content
      flash_cards = Trello::List.find("675fcd452ff58169ebd0962c").cards.shuffle
      flashcards_yaml = flash_cards.map do |card|
        <<~YAML
          - question: #{card.name}
            answer: #{card.desc}
        YAML
      end.join

      <<~CONTENT
        ---
        layout: default
        title: SumitPati7
        flashcards:
        #{flashcards_yaml}
        ---

        ### Here are some of my posts till date

        {% include posts.html %}

        {% include flashcard.html %}
      CONTENT
    end

    def write_index_file
      content = generate_index_content
      File.open("./index.md", "w+") { |f| f.write(content) }
    end

    def generate(site)
      setup
      write_index_file

      cards = Trello::List.find("675929a3f63a634e40a6b169").cards

      cards.each do |card|
        flashcards_yaml = ""

        due_on = card.due&.to_date.to_s
        slug = card.name.downcase.strip.gsub(/\s+/, '-')
        created_on = DateTime.strptime(card.id[0..7].to_i(16).to_s, '%s').to_date.to_s
        article_date = due_on.empty? ? created_on : due_on

        flash_cards = Trello::List.find("675fcd452ff58169ebd0962c").cards

        labels_yaml = ""

        card.labels.each do |label|
          labels_yaml += <<~YAML
            - name: #{label.name}
              color: #{label.color}
          YAML
        end

        flash_cards.each do |flash_card|
          flash_card_labels = flash_card.labels.map(&:name).uniq
          if flash_card_labels.include?(card.name)
            flashcards_yaml += <<~YAML
              - question: #{flash_card.name}
                answer: #{flash_card.desc}
            YAML
          end
        end

        content = <<~POST
          ---
          layout: post
          title: #{card.name}
          date: #{article_date}
          flashcards:
          #{flashcards_yaml}
          labels:
          #{labels_yaml}
          ---
          #{card.desc}
        POST

        filename = "./_posts/#{article_date}-#{slug}.md"
        File.open(filename, "w+") { |f| f.write(content) }
      end
    end
  end
end
