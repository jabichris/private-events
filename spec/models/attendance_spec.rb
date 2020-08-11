require 'rails_helper'

RSpec.describe Attendance, type: :model do
  context 'Attendances relation with Users:' do
    it 'can store multiple attendees.' do
      attendee = Attendance.reflect_on_association(:attendee)
      expect(attendee.macro).to eq(:belongs_to)
    end
  end

  context 'Attendances relation with Events:' do
    it 'can store multiple attended events.' do
      attended_event = Attendance.reflect_on_association(:attended_event)
      expect(attended_event.macro).to eq(:belongs_to)
    end
  end
end
