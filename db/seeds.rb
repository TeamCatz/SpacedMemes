# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


file = File.read('data/output.json')
data = JSON.parse(file)

data.each do |element|

  title = element['title']
  src = element['url']
  tags = []
  if element['concepts'].is_a? Hash then
    element['concepts'].each do |index, tag|
      tags << tag
    end
  end
  date = element['date']
  if src and src.length > 0 then
    if date.length == 0 then
      date = 'null'
    else
      date = "'#{date}'"
    end
    base_image = BaseImage.create(src: src, title: title, date: date)
    tags.each do |tag|
      tag = Tags.create(base_image: base_image, tag: tag)
    end
  end
end

