class Employee
  attr_accessor :boss
  def initialize name, title, salary, boss = nil
    @name, @title, @salary, @boss = name, title, salary, boss
  end
  def bonus multiplier
    @salary * multiplier
  end
end

class Manager < Employee
  def initialize name, title, salary, boss = nil, employees = []
    super name, title, salary, boss
    @employees = employees
  end

  def bonus multiplier
    bonus = 0
    queue = employees
    until queue.empty?
      employee = queue.shift
      bonus += employee.salary * multiplier
      queue += employee.employees
    end
    bonus
  end
end
