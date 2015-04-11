require 'json'
require 'pg'

host = 'localhost' ## UPDATE
database = 'spaceapps2015'
user = ''
password = '' ## UPDATE
port = 5432


conn = PGconn.connect(:host => host, :port => port, :user => user, :password => password, :dbname => database)
conn.prepare('base_image', 'insert into base_images (src, title, date) values ($1, $2, $3) returning id')
conn.prepare('tags', 'insert into tags (base_image_id, tag) values ($1, $2)')
file = File.read('output.json')

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
    res = conn.exec_prepared('base_image', [src, title, date])
    id = res[0]['id']
    tags.each do |tag|
      conn.exec_prepared('tags', [id, tag])
    end
  end
end

