class Character < ActiveRecord::Base
    validates :name, :character_class, :race, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, presence: true

    belongs_to :user
end
