class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' }, 
    { id: 2, name: 'グルメ' },
    { id: 3, name: 'レジャー' }, 
    { id: 4, name: '宿泊' },
    { id: 5, name: 'その他' }, 
  ]
  include ActiveHash::Associations
  has_many :posts

end