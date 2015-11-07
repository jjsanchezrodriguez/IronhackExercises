class AddConcertPosters < ActiveRecord::Migration
  def change
    def up
      add_attachment :concerts, :avatar
    end

    def down
      remove_attachment :concerts, :avatar
    end
  end
end
