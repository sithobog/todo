class CreateEntry
  def self.create_entry_for_users
    users = User.all
    users.each do |user|
      user.entries.create(day: Date.today, body: "Empty body")
    end
  end
end