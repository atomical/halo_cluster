class AddUser < ActiveRecord::Migration
  def up
    User.create(email: "adam.t.hallett@gmail.com", password: "faucets1")
  end

  def down
    User.find_by(email: "adam.t.hallett@gmail.com").destroy rescue true
  end
end
