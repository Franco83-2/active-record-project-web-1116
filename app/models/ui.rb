class Ui

  def self.greeting
    puts "Welcome to the digital library. Enter your user name:"
    puts ""
    person = User.who_are_you
    puts ""
    puts "Hello #{person.name}! You are account number #{person.id}."
    puts "Let's get you started!"
    puts ""
    person
  end

  def self.user_choice
    puts ""
    puts "Which of the following options would you like to perform?"
    puts "You can choose from:"
    puts "1. Checkout a book"
    puts "2. Return a book"
    puts "3. Check what you currently have checked out"
    puts "4. Check what you have previously checked out"
    puts "5. Quit"
    puts ""
    gets.strip
  end

  def self.main_menu(user)
    while true
      case self.user_choice
        when "1"
          Ui.checkout(user)
        when "2"
          Ui.return_a_book(user)
        when "3"
          puts ""
          if user.userbooks.where(returned: false).count > 0
            user.userbooks.where(returned: false).each.with_index(1) do |book,index|
              puts "#{index}. #{book.book.title}"
            end
          else
            puts "You have no books, loser."
          end
          puts ""
        when "4"
          puts ""
          if user.userbooks.where(returned: true).count > 0
            user.userbooks.where(returned: true).each.with_index(1) do |book,index|
              puts "#{index}. #{book.book.title}"
            end
          else
            puts "You never checked out a book, loser."
          end
          puts ""
        when "5"
          break
        else
          puts "That is not valid"
        end
      end
    end

  def self.category_menu
    puts "Here is a list of categories we offer:"
    puts  Category.all.map {|cat, index| cat.name}.uniq
    puts "Select a category:"
    answer = gets.strip.downcase.capitalize
    answer
  end

  def self.book_menu
    booklist = category_menu
    list = Book.all.map {|book| book.title if book.category.name == booklist}.compact
    puts ""
    list.each.with_index(1) {|book, index| puts "#{index}. #{book}"}
    list
  end

  def self.selection
    data = book_menu
    puts "Which book would you like to checkout?"
    choice = gets.strip
    newbookname = data[choice.to_i-1]
    # TODO: use find by instead of where
    Book.where(title: newbookname)[0]
  end

  def self.checkout(user)
    chosen = self.selection
    puts ""
      if chosen.available == true
        self.checkout_choice(chosen, user)
      else
        puts "#{chosen.title} by #{chosen.author.name} is currently unavailable. it should be returned by #{chosen.userbooks.find_by(book_id: chosen.id).due_date}."
        puts "Please make another selection."
      end
  end

  def self.checkout_choice_loop(chosen, user)
    decision = gets.strip.downcase
    while decision != "y" || decision != "n"
      if decision == "y"
        self.checkout_yes(chosen, user)
        break
      elsif decision == "n"
        puts "Ok, let's go back and make another selection"
        break
      end
      puts "That is not a valid option. Please try again."
      decision = gets.strip.downcase
    end
  end

  def self.checkout_choice(chosen, user)
    puts "#{chosen.title} by #{chosen.author.name} is currently available. Would you like to check it out?"
    puts ""
    self.checkout_choice_loop(chosen, user)
    puts "Returning to main menu!"
  end

  def self.return_a_book(user)
    list = user.userbooks.where(returned: false)
     while list != []
        puts "You have the following books:"
          list.each.with_index(1) do |book, index|
            puts "#{index}. #{book.book.title}"
          end
        puts "Which would you like to return? (Number)"
        answer = gets.strip
        if list[answer.to_i-1] != []
          list[answer.to_i-1].update(returned: true, return_date: "#{Time.now.month}/#{Time.now.day}")
          list[answer.to_i-1].book.update(available: true)
          puts "You have returned #{list[answer.to_i-1].book.title}!"
        end
        list = user.userbooks.where(returned: false)
      end
      puts "You have no more books!"
      puts ""
    end

  def self.checkout_yes(chosen, user)
    issue_date = Time.now
    due_date = issue_date + (2*7*24*60*60)
    chosen.update(available: false)
    user.books << chosen
    user.userbooks.find_by(book_id: chosen.id).update(issue_date: "#{issue_date.month}/#{issue_date.day}", due_date: "#{due_date.month}/#{due_date.day}", returned: false)
    puts "#{chosen.title} needs to be returned by #{chosen.userbooks.find_by(book_id: chosen.id).due_date}"
  end

end
