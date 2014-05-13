require 'sinatra'

##
# swap items at position x and y in array seq
# up to the caller to bounds check
# no return, modifies passed array
def swap(seq, x, y)
    tmp = seq[x]
    seq[x] = seq[y]
    seq[y] = tmp
end

##
# create a comparison table of a sequence of 4 numbers
# in the format used by balihoo. Example:
#    ABCD
#   A=<<<
#   B>=>>
#   C><=<
#   D><>=
# returns this as a string
def format_puzzle_answer(seq)
    s = " ABCD"
    for x in 0..3
        s += "\n"
        s += "ABCD"[x] #use string index to start with the right letter
        for y in 0..3
            if seq[x] > seq[y]
                s += '>'
            elsif seq[x] < seq[y]
                s += '<'
            else
                s += '='
            end
        end
    end
    return s
end

##
# parses the given table as received
# then generate a matching sequence of the numbers 1 through 4
# to match the given data. Note that when multiple solutions are
# possible, only the first one found is returned. Also note that
# when there are no solutions (inconsistent data is provided) this
# algorithm results in an infinite loop. (A simple test for time or
# max cycles could avoid this)
# returns a matching table formatted as the input
def solve_puzzle(pzl)
    given = pzl.lines.map(&:chomp)
    if given.length() > 5
        given = given[2..5]
    else
        return "Invalid Puzzle: #{pzl}"
    end

    # start with the default sequence
    seq = [1,2,3,4]
    changed = true
    # loop until the sequence conforms to the provided constraints
    while changed
        changed = false
        #loop over the rows and columns of the table
        for x in 0..3
            for y in 0..3
                # if a given entry does not match the sequence
                # swap the items in the sequence to make it match
                if ((given[y][x+1] == '>' and seq[x] > seq[y]) or
                    (given[y][x+1] == '<' and seq[x] < seq[y]))
                    swap(seq, x, y)
                    changed = true
                end
            end
        end
    end

    return format_puzzle_answer(seq)
end

##
# main web app to process GET requests
get '/' do
    @q = params[:q]
    case @q
    when "Ping"
        "OK"
    when "Referrer"
        "Zach Dorsch"
    when "Puzzle"
        solve_puzzle(params[:d])
    when "Position"
        "Sr. Software Developer"
    when "Name"
        "Gerry Ens"
    when "Status"
        "Yes! Greencard, Dutch Citizenship"
    when "Resume"
        "http://www.ensotrading.com/G_Ens_Resume_Balihoo.pdf"
    when "Source"
        "https://github.com/ghe/balihoo"
    when "Degree"
        "MS Computer Science, Northeastern University, Boston, 2005"
    when "Email Address"
        "GerardEns@gmail.com"
    when "Phone"
        "(617) 909-8867"
    when "Years"
        "20+, I'm 35 and have been programming since I was 7 or 8. Didn't get paid for it until I was in my late teens though..."
    else
        "Got: #{@q} ?"
    end
end
