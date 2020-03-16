namespace :dev do
  desc "Configurando Ambiente"
  task setup: :environment do
        puts  "Cadastrando tags"
    
        5.times do |i|
            Tag.create!(name: Faker::Lorem.characters(number: 6))
        end

        Tag.all.each do |tag|
            Random.rand(6).times do |j|
                q = Quote.create!(
                    quote: Faker::Lorem.sentence(word_count: 10),
                    author: Faker::Name.name,
                    author_about: Faker::Internet.email,
                    tags: Faker::Lorem.words(number: 4),
                    tag: tag
                )   
                tag.quotes << q
                tag.save
            end
        end
    end
end