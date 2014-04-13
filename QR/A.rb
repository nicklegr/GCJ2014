require 'pp'

def ppd(*arg)
  if $DEBUG
    pp(*arg)
  end
end

def putsd(*arg)
  if $DEBUG
    puts(*arg)
  end
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  for i in 1 .. count
    words << readline.chomp
  end
  words
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  # readline().chomp
  # readline().split

  a = ri
  cards_a = []
  4.times do
    cards_a << ris
  end

  b = ri
  cards_b = []
  4.times do
    cards_b << ris
  end

ppd cards_a, cards_b

  as = cards_a[a-1].sort
  bs = cards_b[b-1].sort

ppd as, bs

  same = 0
  card = -1
  as.each do |e|
    if bs.include?(e)
      same += 1
      card = e
    end
  end

  if same == 0
    puts "Case ##{case_index}: Volunteer cheated!"
  elsif same == 1
    puts "Case ##{case_index}: #{card}"
  else
    puts "Case ##{case_index}: Bad magician!"
  end

  # progress
  trigger = 
    if cases >= 10
      case_index % (cases / 10) == 0
    else
      true
    end

  if trigger
    STDERR.puts("case #{case_index} / #{cases}, time: #{Time.now - t_start} s")
  end
end
