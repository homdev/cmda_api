class Experience < ApplicationRecord
    belongs_to :user
  
    validates :title, :company_name, :start_date, presence: true
    validates :end_date, comparison: { greater_than: :start_date }, if: -> { end_date.present? }
  end
  