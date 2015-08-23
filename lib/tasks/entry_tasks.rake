desc 'create entries'
task create_entries: :environment do
  CreateEntry.create_entry_for_users
end