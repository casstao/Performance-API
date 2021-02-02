class Dino < ApplicationRecord
    belongs_to :cage
    validates :name, presence: true
    validates :species, presence: true
    validates :dino_type, presence: true
    


end
