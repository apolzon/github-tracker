# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :project do |p|
  p.name "MyString"
  p.url "MyString"
  p.user { Factory :user }
end

Factory.define :github_project do |p|
  p.name "MyString"
  p.url "MyString"
  p.user { Factory :user }
end

Factory.define :pivotal_project do |p|
  p.name "MyString"
  p.url "MyString"
  p.user { Factory :user }
  p.api_token "MyToken"
end
