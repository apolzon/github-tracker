# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.name "MyString"
  f.sequence(:email) {|n| "MyString#{n}"}
  f.password "mypassword"
end
