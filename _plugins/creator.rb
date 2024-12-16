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
    
    def indexGenerate
      flash_cards = Trello::List.find("675fcd452ff58169ebd0962c").cards.shuffle!
      flashcards = ""
      i=0
      while i < flash_cards.count do
        flashcards+= """
  - question: """ + flash_cards[i].name + """
    answer: """ + flash_cards[i].desc + """
            """
        i = i+1
      end
      indexContent = """---
layout: default
title: SumitPati7
flashcards: """ + flashcards + """
---
# Hello There, I am Sumit Pati.

#### Diligent | Adaptable | Curious
Enthusiastic student majoring in Computer Science and Information Technology. Passionate about coding, problem-solving, and staying up-to-date with industry trends. During my studies, I collaborated on several group projects, honing my teamwork and communication skills. Eager to contribute my knowledge and learn from experienced professionals, I am committed to making a positive impact in the field.

My coursework has equipped me with a solid foundation in Data Structures and Algorithm, Database, Web Design, etc and I'm actively seeking opportunities to gain real-world experience in this field.

### Here are some of my posts till date 

{% for post in site.posts limit: 5 %}
  * {{ post.date | date: '%Y %b %d'}} >> [{{ post.title }}]({{site.baseurl}}{{ post.url }})
{% endfor %}

{% include flashcard.html %}
      """
      file = File.open("./index.md","w+") { |f| f.write(indexContent) }
    end

    def generate(site)
      setup
      indexGenerate
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
