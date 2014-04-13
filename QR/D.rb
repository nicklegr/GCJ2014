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

def deceitful_war(blocks, naomis, kens)
  np = 0
  kp = 0

  ns = naomis.dup.sort
  ks = kens.dup.sort.reverse

  blocks.times do
    n = ns.shift

    k = -1
    naomi_lose = true
    for i in 0...ks.size
      if ks[i] < n
        naomi_lose = false
        break
      end
    end

    if naomi_lose
      index = 0
    else
      index = ks.size - 1
    end

    raise if index == -1
    k = ks[index]
    ks.delete_at(index)
ppd n, k

    raise if n == k
    if n > k
      np += 1
    else
      kp += 1
    end
  end

  return np
end

def war(blocks, naomis, kens)
  np = 0
  kp = 0

  ns = naomis.dup.sort.reverse
  ks = kens.dup.sort

  blocks.times do
    n = ns.shift

    k = -1
    index = -1
    for i in 0...ks.size
      if ks[i] > n
        index = i
        break
      end
    end

    if index == -1
      index = 0
    end

    raise if index == -1
    k = ks[index]
    ks.delete_at(index)

    raise if n == k
    if n > k
      np += 1
    else
      kp += 1
    end
  end

  return np
end

# main
t_start = Time.now

# 問題に応じて
cases = readline().to_i

(1 .. cases).each do |case_index|
  # readline().chomp
  # readline().split

  n = ri
  naomis = rfs
  kens = rfs

  puts "Case ##{case_index}: #{deceitful_war(n, naomis, kens)} #{war(n, naomis, kens)}"

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
