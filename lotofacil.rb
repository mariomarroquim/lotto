#!/usr/bin/env ruby
# frozen_string_literal: true

# Generates valid tickets for the Brazilian lottery "Lotofácil". See lotofacil.md.
class TicketGenerator
  POOL = (1..25).to_a.freeze
  TICKET_SIZE = 15
  ODD_RANGE = (6..10).freeze
  SUM_RANGE = (146..245).freeze
  CANDIDATE_DRAWS = 999
  MODES = %w[different similar].freeze

  attr_reader :amount, :mode

  def initialize(raw_amount, raw_mode)
    @amount = [raw_amount.to_i, 1].max
    mode = raw_mode.to_s.downcase
    @mode = MODES.include?(mode) ? mode : MODES.first
  end

  def run
    puts "Lotofácil Ticket Generator"
    puts "Amount: #{amount}"
    puts "Mode: #{mode}"
    puts "Rules: #{TICKET_SIZE} unique numbers (#{pad(POOL.first)}-#{pad(POOL.last)}) | " \
         "Odds: #{ODD_RANGE} | Sum: #{SUM_RANGE} | Unique tickets"
    puts "-" * 80

    tickets.each.with_index(1) do |(numbers, score), index|
      puts "Ticket #{pad(index)}: [ #{numbers.map { |n| pad(n) }.join(' - ')} ] " \
           "(Odds: #{pad(numbers.count(&:odd?))}, Sum: #{numbers.sum}, Score: #{pad(score)})"
    end
  end

  private

  def tickets
    baseline = draw_ticket until valid?(baseline)
    accepted = [baseline]
    candidates = []

    CANDIDATE_DRAWS.times do
      ticket = draw_ticket
      next if !valid?(ticket) || accepted.include?(ticket)

      # Same score in both modes: highest overlap with any earlier ticket. Higher = more similar.
      score = accepted.map { |other| (ticket & other).size }.max
      candidates << [ticket, score]
      accepted << ticket
    end

    sorted = candidates.sort_by { |_, score| mode == "similar" ? -score : score }
    ([[baseline, 0]] + sorted).first(amount)
  end

  def draw_ticket = POOL.sample(TICKET_SIZE).sort

  def valid?(ticket)
    !ticket.nil? && ODD_RANGE.cover?(ticket.count(&:odd?)) && SUM_RANGE.cover?(ticket.sum)
  end

  def pad(number) = format("%02d", number)
end

TicketGenerator.new(ARGV[0], ARGV[1]).run if __FILE__ == $PROGRAM_NAME
