class Status < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' }, 
    { id: 2, name: '一人旅' }, 
    { id: 3, name: '友達と' }, 
    { id: 4, name: '恋人と' },
    { id: 5, name: '家族と' }, 
    { id: 6, name: 'その他' }

  ]
  include ActiveHash::Associations
  has_many :posts

end