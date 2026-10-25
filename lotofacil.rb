#!/usr/bin/env ruby
# frozen_string_literal: true

class LotofacilGenerator
  POOL = (1..25).to_a.freeze
  TICKET_SIZE = 15
  ODD_RANGE = (6..10).freeze
  SUM_RANGE = (146..245).freeze
  CANDIDATE_DRAWS = 999
  MODES = %w[different similar].freeze
  DEFAULT_MODE = "different"

  attr_reader :amount, :mode

  def initialize(raw_amount = nil, raw_mode = nil)
    @amount = [raw_amount.to_i, 1].max

    normalized_mode = raw_mode.to_s.downcase
    @mode = MODES.include?(normalized_mode) ? normalized_mode : DEFAULT_MODE
  end

  def tickets
    baseline = draw_valid_ticket
    accepted = [baseline]
    candidates = []

    CANDIDATE_DRAWS.times do
      ticket = random_ticket
      next unless valid?(ticket)
      next if accepted.include?(ticket)

      candidates << { numbers: ticket, score: score(ticket, accepted) }
      accepted << ticket
    end

    sorted = candidates.sort_by { |c| similar? ? -c[:score] : c[:score] }
    ([{ numbers: baseline, score: 0 }] + sorted).first(amount)
  end

  def print_report
    puts "Lotofácil Ticket Generator"
    puts "Amount: #{amount}"
    puts "Mode: #{mode}"
    puts "Rules: #{TICKET_SIZE} unique numbers (01-25) | Odds: #{ODD_RANGE} | " \
         "Sum: #{SUM_RANGE} | Unique tickets"
    puts "-" * 80

    tickets.each.with_index(1) do |ticket, index|
      numbers = ticket[:numbers]
      formatted = numbers.map { |n| pad(n) }.join(" - ")

      puts "Ticket #{pad(index)}: [ #{formatted} ] " \
           "(Odds: #{pad(numbers.count(&:odd?))}, Sum: #{numbers.sum}, Score: #{pad(ticket[:score])})"
    end
  end

  private

  def similar? = mode == "similar"

  def pad(number) = format("%02d", number)

  def random_ticket = POOL.sample(TICKET_SIZE).sort

  def valid?(ticket)
    ODD_RANGE.cover?(ticket.count(&:odd?)) && SUM_RANGE.cover?(ticket.sum)
  end

  def draw_valid_ticket
    loop do
      ticket = random_ticket
      return ticket if valid?(ticket)
    end
  end

  # Overlap = shared numbers; "different" keeps the worst case (max), "similar" the best case (min).
  def score(ticket, accepted)
    overlaps = accepted.map { |other| (ticket & other).size }
    similar? ? overlaps.min : overlaps.max
  end
end

LotofacilGenerator.new(ARGV[0], ARGV[1]).print_report if __FILE__ == $PROGRAM_NAME
